module CorevistAPI
  class Forms::Document::SortItemsForm < CorevistAPI::Forms::BaseForm
    validate_component :filter_items_form, on_page: :show_document_items
  end
end
