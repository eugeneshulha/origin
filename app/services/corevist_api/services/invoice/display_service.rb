module CorevistAPI
  module Services::Invoice
    class DisplayService < CorevistAPI::Services::BaseService

      def call
        perform!
      end

      private

      def perform!
        @rfc_result = rfc_service_for(:invoice_display, @object, @params).call
        result(@rfc_result)
      end
    end
  end
end
