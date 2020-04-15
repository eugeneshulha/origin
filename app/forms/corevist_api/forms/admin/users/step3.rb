#
# roles user can assign
#
module CorevistAPI
  module Forms
    class Admin::Users::Step3 < CorevistAPI::Forms::BaseForm
      validate_component :roles_can_assign_of_new_user_form, on_page: :admin_users_create_step_3
    end
  end
end
