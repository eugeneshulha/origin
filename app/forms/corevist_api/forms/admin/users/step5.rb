#
# assigned ship tos
#
module CorevistAPI
  module Forms
    class Admin::Users::Step5 < CorevistAPI::Forms::BaseForm
      validate_component :ship_tos_of_new_user_form, on_page: :admin_users_create_step_5
    end
  end
end
