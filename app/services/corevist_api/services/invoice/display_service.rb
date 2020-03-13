module CorevistAPI
  module Services::Invoice
    class DisplayService < CorevistAPI::Services::BaseService
      def call
        perform!
      end

      private

      def perform!
        @rfc_result = rfc_service_for(:invoice_display, @object, @params).call

        invoice = builder_for(:invoice, @rfc_result.data).build do |builder|
          builder.with_configs
          builder.with_items
          builder.with_header
          builder.with_prices
          builder.with_partners
        end

        result(invoice.as_json)
      end
    end
  end
end
