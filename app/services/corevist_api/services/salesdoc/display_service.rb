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

        result(salesdoc.as_json)
      end
    end
  end
end
