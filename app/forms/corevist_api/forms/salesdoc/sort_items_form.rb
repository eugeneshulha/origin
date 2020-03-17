module CorevistAPI
  class Forms::Salesdoc::SortItemsForm < CorevistAPI::Forms::BaseForm
    validate_component :filter_items_form, on_page: :show_salesdoc_items
  end
end
