module CorevistAPI
  module Forms::Accounts
    class UpdateForm < CorevistAPI::Forms::BaseForm
      validate_component :user_profile_form, on_page: :accounts_edit

    end
  end
end
