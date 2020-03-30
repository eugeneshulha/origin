module CorevistAPI
  class Forms::Invoice::ListForm < CorevistAPI::Forms::BaseForm
    validate_component :invoice_filter_form, on_page: :filter_invoice_list
  end
end
