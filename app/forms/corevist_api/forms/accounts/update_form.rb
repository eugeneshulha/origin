module CorevistAPI
  module Forms::Accounts
    class UpdateForm < CorevistAPI::Forms::BaseForm
      validate_component :account_update_form, on_page: :accounts_update

    end
  end
end
