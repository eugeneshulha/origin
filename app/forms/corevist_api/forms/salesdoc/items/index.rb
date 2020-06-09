module CorevistAPI
  class Forms::Salesdoc::Items::Index < CorevistAPI::Forms::BaseForm
    validate_component :filter_items_form, on_page: :salesdocs_items_index
  end
end
