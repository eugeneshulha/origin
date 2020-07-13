module CorevistAPI::Services::Invoices
  class IndexService < CorevistAPI::Services::BaseServiceWithForm

    private

    def perform
      @rfc_result = rfc_service_for(:invoice_list, @form, @params).call

      invoices = @rfc_result.data.inject([]) do |memo, doc|
        invoice = builder_for(:basic_invoice, doc).build do |builder|
          builder.with_header
          builder.with_item_data
        end

        memo << invoice
      end

      invoices = filter_by_query(invoices)
      invoices = sort_by_param(invoices)
      invoices = paginate(items: invoices.map { |x| x.as_json(:short) })
      result(invoices)
    end
  end
end
