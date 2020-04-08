module CorevistAPI
  module Forms::Invoice::Question
    class Create < CorevistAPI::Forms::BaseForm
      validate_component :invoices_questions_create_form, on_page: :invoices_questions_create
    end
  end
end
