module CorevistAPI
  class Forms::User::SetNewPassword < CorevistAPI::Forms::BaseForm
    include CorevistAPI::FormValidations

    def params_key
      :user
    end
  end
end
