module CorevistAPI
  module Services
    class Admin::Users::Step4CreationService < BaseServiceWithForm

      # sp - sold-to
      # sh - ship-to
      # py - payer
      FUNCTIONS_MAP = {
        sp: :AG,
        sh: :WE
      }.freeze
      KEY_FUNCTION = 'function'.freeze
      KEY_NUMBER = 'number'.freeze

      def perform
        raise CorevistAPI::ServiceException.new(not_found_msg) unless user

        assigned_partners = user.assigned_partners.where(function: function_name(excluded_function))
        raise CorevistAPI::ServiceException.new("api.#{namespace}.one_function") if assigned_partners.present?

        partners = @form.partners.each_with_object([]) do |data, memo|
          next if data[KEY_FUNCTION].to_sym == function_name(excluded_function)

          partners = process_partner(data[KEY_NUMBER])
          memo << partners
        end

        user.partners = partners.flatten
        result(user)
      end

      private

      def function_name(function)
        FUNCTIONS_MAP.dig(function)
      end

      def process_partner(number)
        object = OpenStruct.new(partner_number: number)
        @rfc_result = rfc_service_for(:get_partner, object, @params).call
        @rfc_partner = @rfc_result.data[:partner]
        @partner_sales_data = @rfc_result.data[:partner_sales_data]

        sales_areas = @partner_sales_data.collect(&:sa)
        sales_areas.each_with_object([]) do |sales_area, memo|
          fetch_sales_data(sales_area).each do |sales_data|
            next unless sales_data.send(function).sap_to_boolean

            sales_area_entry = CorevistAPI::SalesArea.find_by_title(sales_area)
            memo << build_partner(sales_area_entry, function_name(function), sales_data)
          end
        end
      end

      def build_partner(sales_area, function, sales_data)
        partner_params = {
          sales_area: sales_area,
          user: user,
          rfc_partner: @rfc_partner,
          sales_data: sales_data,
          function: function,
          postal_addresses: @rfc_result.data[:postal_addresses],
          street_addresses: @rfc_result.data[:street_addresses]
        }

        partner = builder_for(:partner, partner_params).build do |builder|
          builder.with_base_params
          builder.with_assigned_param
          builder.with_postal_addresses
          builder.with_street_addresses
        end
        raise CorevistAPI::ServiceException.new(partner.errors.full_messages) unless partner.valid?

        partner
      end

      def fetch_sales_data(sales_area)
        @partner_sales_data.select { |data| data.sa == sales_area && data.nr == @rfc_partner.nr }
      end

      def function
        :sp
      end

      def excluded_function
        :sh
      end
    end
  end
end
