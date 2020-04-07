module CorevistAPI
  class Forms::Document::OutputTypesList < CorevistAPI::Forms::BaseForm
    validate_component :output_types_form, on_page: :output_types_index
  end
end
