module CorevistAPI
  class Forms::Invoice::ListForm < CorevistAPI::Forms::BaseForm
    validate_component :invoice_filter_form, on_page: :invoices_index
  end
end
