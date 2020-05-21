module CorevistAPI
  module Forms
    class Admin::Roles::CreateForm < CorevistAPI::Forms::BaseForm
      validate_component :role_create_form, on_page: :admin_roles_create
    end
  end
end
