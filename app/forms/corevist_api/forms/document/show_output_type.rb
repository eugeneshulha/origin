module CorevistAPI
  class Forms::Document::ShowOutputType < CorevistAPI::Forms::BaseForm
    validate_component :show_output_types_form, on_page: :output_types_show
  end
end
