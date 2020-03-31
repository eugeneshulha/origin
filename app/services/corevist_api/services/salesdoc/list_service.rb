module CorevistAPI
  module Services::Salesdoc
    class ListService < CorevistAPI::Services::BaseServiceWithForm
      include CorevistAPI::Services::Paginatable
      include CorevistAPI::Services::Sortable

      private

      def perform!
        @rfc_result = rfc_service_for(:salesdoc_list, @form, @params).call

        array = filter_by_query(@rfc_result.data)
        array = sort_by_param(array)

        invoices = paginate(salesdocs: array)
        result(invoices)
      end
    end
  end
end
