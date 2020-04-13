module CorevistAPI
  module Services::Salesdoc
    class DisplayService < CorevistAPI::Services::BaseService

      def call
        perform!
      end

      private

      def perform!
        @rfc_result = rfc_service_for(:salesdoc_display, @object, @params).call

        salesdoc = builder_for(:salesdoc, @rfc_result.data).build do |builder|
          builder.with_configs
          builder.with_items
          builder.with_header
          builder.with_prices
          builder.with_partners
          builder.with_deliveries
        end

        salesdoc = prepare_response(salesdoc)

        result(salesdoc.as_json)
      end

      def prepare_response(doc)
        price_components = {
            title: "Pricing details",
            content_type: 'table',
            data: doc.price_components.map do |pc|
              { title: "label for #{pc.cond_type}", text: pc.value_formatted }
            end
        }

        partners = doc.partners.map do |partner|
          { title: "Partner #{partner.function}", text: "#{partner.street_address_1}, #{partner.street_address_2}, #{partner.street_address_3}" }
        end

        doc_details = {
            title: "title for salesdoc",
            data: [
                *partners,
                { title: 'Sales Area', text: @rfc_result.data['header'].sa },
                { title: 'Doc type', text: @rfc_result.data['header'].doc_type }
            ]
        }

        deliveries = if doc.deliveries.present?
                       {
                           title: "Salesdoc deliveries",
                           content_type: 'table',
                           data: doc.deliveries.map do |delivery|
                             {
                               delivery_date: delivery.delivery_date, delivery_number: delivery.number,
                               carrier: delivery.carrier_number, tracking_number: delivery.tracking_number
                             }
                           end
                       }
                     else []
                     end
                       

        [].tap do |arr|
          arr << price_components
          arr << doc_details
          arr << deliveries if deliveries.present?
        end
      end
    end
  end
end
