module CorevistAPI
  module Forms
    class Admin::Users::ShowForm < CorevistAPI::Forms::BaseForm
      validate_component :users_show_form, on_page: :admin_users_show
    end
  end
end
