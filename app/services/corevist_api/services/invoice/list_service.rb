module CorevistAPI
  module Services::Invoice
    class ListService < CorevistAPI::Services::BaseServiceWithForm
      include CorevistAPI::Services::Paginatable

      def call
        perform!
      end

      private

      def perform!
        @rfc_result = rfc_service_for(:invoice_list, @form, @params).call

        invoices = paginate(invoices: @rfc_result.data)
        result(invoices)
      end
    end
  end
end
