module CorevistAPI
  module Services::Invoice
    class Pay < CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        @rfc_result = rfc_service_for(:pay_invoices, @object, @params).call

        if @rfc_result.data[:payment_doc_number]
          Mailer.pay_invoices_confirmation.deliver_later
        end

        result(@rfc_result.data)
      end
    end
  end
end
