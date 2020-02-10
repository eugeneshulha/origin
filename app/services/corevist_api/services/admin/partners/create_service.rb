module CorevistAPI
  module Services::Admin::Partners
    class CreateService < CorevistAPI::Services::BaseServiceWithForm
      def perform
        uuid = @form.try(:user_uuid)
        return result.fail!([I18n.t('api.services.no_uuid')]) if (user = CorevistAPI::User.find_by_uuid(uuid)).blank?

        rfc_result = rfc_service_for(:get_partner).call
        @rfc_partner = rfc_result.data[:partner]
        @partner_sales_data = rfc_result.data[:partner_sales_data]
        @postal_addresses = rfc_result.data[:postal_addresses]
        @street_addresses = rfc_result.data[:street_addresses]

        sales_areas = @partner_sales_data.collect(&:sa)
        sales_areas.each do |sales_area|
          %i[sp sh py].each do |function|
            fetch_sales_data(sales_area).each do |sales_data|
              next unless sales_data.send(function).sap_to_boolean

              sales_area_entry = CorevistAPI::SalesArea.find_by_title(sales_area)
              function_name = get_function_name(function)
              upsert_partner(sales_area_entry, function_name, sales_data, user)
            end
          end
        end
        result(partners: user.partners)
      end

      def invalid_object_error
        result.fail!(@form.errors.full_messages)
      end

      private

      # sp - sold-to
      # sh - ship-to
      # py - payer
      def get_function_name(function)
        {
          sp: :AG,
          sh: :WE,
          py: :RG
        }[function]
      end

      def upsert_partner(sales_area, function, sales_data, user)
        CorevistAPI::Partner.find_or_initialize_by(sales_area_id: sales_area.id, number: @rfc_partner.nr, function: function) do |partner|
          partner.sales_area = sales_area
          partner.user = user
          partner.number = @rfc_partner.nr
          partner.payment_terms = sales_data.payment_terms
          partner.function = function
          partner.name = @rfc_partner.name1
          partner.state = @rfc_partner.state
          partner.country = @rfc_partner.country
          partner.city = @rfc_partner.city
          partner.email = @rfc_partner.email
          partner.language = @rfc_partner.lang
          partner.deleted = @rfc_partner.del.sap_to_boolean

          @postal_addresses.each_with_index do |postal_address, index|
            partner.send("postal_address_#{index + 1}=", postal_address.line)
          end

          @street_addresses.each_with_index do |street_address, index|
            partner.send("street_address_#{index + 1}=", street_address.line)
          end
        end.save
      end

      def fetch_sales_data(sales_area)
        @partner_sales_data.select { |data| data.sa == sales_area && data.nr == @rfc_partner.nr }
      end
    end
  end
end
