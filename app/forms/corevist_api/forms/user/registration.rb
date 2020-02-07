module CorevistAPI
  class Forms::User::Registration < CorevistAPI::Forms::BaseForm
    include CorevistAPI::FormValidations
    validate_form


    def params_key
      :user
    end
  end
end
