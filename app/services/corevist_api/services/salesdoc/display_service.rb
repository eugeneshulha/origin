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
        end

        salesdoc = prepare_response(salesdoc)

        result(salesdoc.as_json)
      end

      def prepare_response(doc)
        price_components = {
            title: "Pricing details",
            content_type: 'table',
            data: @rfc_result.data['price_components'].map do |pc|
              { title: "label for #{pc.cond_type}", text: pc.value }
            end
        }

        partners = @rfc_result.data['partners'].map do |partner|
          { title: "Partner #{partner.fct}", text: "#{partner.name1}, #{partner.city}" }
        end

        doc_details = {
            title: "title for salesdoc",
            data: [
                *partners,
                { title: 'Sales Area', text: @rfc_result.data['header'].sa },
                { title: 'Doc type', text: @rfc_result.data['header'].doc_type }
            ]
        }

        [].tap do |arr|
          arr << price_components
          arr << doc_details
        end
      end
    end
  end
end
