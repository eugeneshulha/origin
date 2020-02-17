module CorevistAPI
  module Builders
    class PartnerBuilder < BaseBuilder
      MAX_ADDRESSES_COUNT = 3

      def build
        yield(self)
        @object
      end

      def with_base_params
        @object.sales_area = sales_area
        @object.user = user
        @object.number = rfc_partner.nr
        @object.payment_terms = sales_data.payment_terms
        @object.function = function
        @object.name = rfc_partner.name1
        @object.state = rfc_partner.state
        @object.country = rfc_partner.country
        @object.city = rfc_partner.city
        @object.email = rfc_partner.email
        @object.language = rfc_partner.lang
        @object.deleted = rfc_partner.del.sap_to_boolean
      end

      def with_assigned_param
        @object.assigned = true
      end

      def with_postal_addresses
        with_addresses(:postal_address)
      end

      def with_street_addresses
        with_addresses(:street_address)
      end

      private

      def with_addresses(type)
        public_send(type.to_s.pluralize).each_with_index do |address, index|
          break if (idx = index + 1) > MAX_ADDRESSES_COUNT

          @object.public_send("#{type}_#{idx}=", address.line)
        end
      end

      def obtain_object(params)
        params[:class].find_or_initialize_by(sales_area_id: sales_area.id, number: rfc_partner.nr, function: function)
      end
    end
  end
end
