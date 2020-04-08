module CorevistAPI
  module Forms::Salesdoc::Question
    class Create < CorevistAPI::Forms::BaseForm
      validate_component :salesdocs_questions_create_form, on_page: :salesdocs_questions_create
    end
  end
end
