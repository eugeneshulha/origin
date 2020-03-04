module CorevistAPI
  class Forms::User::SetNewPassword < CorevistAPI::Forms::BaseForm
    validate_component :forgot_password_2_form, on_page: :forgot_password_2

    def params_key
      :user
    end
  end
end
