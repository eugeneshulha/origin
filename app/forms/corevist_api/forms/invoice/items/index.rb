module CorevistAPI
  class Forms::Invoice::Items::Index < CorevistAPI::Forms::BaseForm
    validate_component :filter_items_form, on_page: :invoices_items_index
  end
end
