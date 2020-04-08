module CorevistAPI
  module Forms
    class Admin::Roles::ShowForm < CorevistAPI::Forms::BaseForm
      validate_component :roles_show_form, on_page: :admin_roles_show
    end
  end
end
