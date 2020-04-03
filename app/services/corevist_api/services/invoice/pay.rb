module CorevistAPI
  module Services::Invoice
    class Pay < CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        @rfc_result = rfc_service_for(:pay_invoices, @object, @params).call

        result(@rfc_result.data)
      end
    end
  end
end
