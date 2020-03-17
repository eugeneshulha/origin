module CorevistAPI
  class Forms::Invoice::SortItemsForm < CorevistAPI::Forms::BaseForm
    validate_component :filter_items_form, on_page: :show_invoice_items
  end
end
