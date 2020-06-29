module CorevistAPI
  module Forms::Salesdocs::Questions
    class CreateForm < CorevistAPI::Forms::BaseForm
      validate_component :salesdocs_questions_create_form, on_page: :salesdocs_questions_create
    end
  end
end
