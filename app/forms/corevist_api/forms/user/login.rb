module CorevistAPI
  class Forms::User::Login < CorevistAPI::Forms::BaseForm
    validate_component :login_form, on_page: :sessions_new

    def params_key
      :user
    end
  end
end
