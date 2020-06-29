module CorevistAPI
  class Forms::Invoices::Items::IndexForm < CorevistAPI::Forms::BaseForm
    validate_component :filter_items_form, on_page: :invoices_items_index
  end
end
