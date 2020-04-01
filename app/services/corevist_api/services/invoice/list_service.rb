module CorevistAPI
  module Services::Invoice
    class ListService < CorevistAPI::Services::BaseServiceWithForm
      include CorevistAPI::Services::Paginatable
      include CorevistAPI::Services::Sortable

      private

      def perform
        @rfc_result = rfc_service_for(:invoice_list, @form, @params).call

        array = filter_by_query(@rfc_result.data)
        array = sort_by_param(array)

        invoices = paginate(invoices: array)
        result(invoices)
      end
    end
  end
end
