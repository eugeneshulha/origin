module CorevistAPI
  module Forms
    class Admin::Roles::UpdateForm < CorevistAPI::Forms::BaseForm
      validate_component :role_update_form, on_page: :admin_roles_update

    end
  end
end
