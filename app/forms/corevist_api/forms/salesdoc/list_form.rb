module CorevistAPI
  class Forms::Salesdoc::ListForm < CorevistAPI::Forms::BaseForm
    validate_component :salesdoc_filter_form, on_page: :salesdocs_index
  end
end
