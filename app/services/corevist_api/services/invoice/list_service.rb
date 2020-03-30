module CorevistAPI
  module Services::Invoice
    class ListService < CorevistAPI::Services::BaseServiceWithForm
      def call
        perform!
      end

      private

      def perform!
        @rfc_result = rfc_service_for(:invoice_list, @form, @params).call
        result(@rfc_result.data.as_json)
      end
    end
  end
end
