#
# assigned roles
#
module CorevistAPI
  module Forms::Admin::Users
    class Step2 < CorevistAPI::Forms::BaseForm
      validate_component :assigned_roles_of_new_user_form, on_page: :admin_users_new_step_2
    end
  end
end
