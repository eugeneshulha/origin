module CorevistAPI::Services::Invoices
  class IndexService < CorevistAPI::Services::BaseServiceWithForm

    private

    def perform
      @rfc_result = rfc_service_for(:invoice_list, @form, @params).call

      array = filter_by_query(@rfc_result.data)
      array = sort_by_param(array)

      invoices = paginate(items: array)
      result(invoices)
    end
  end
end