#
# assigned territories
#
module CorevistAPI
  module Forms
    class Admin::Users::Step6 < CorevistAPI::Forms::BaseForm
      validate_component :territories_of_new_user_form, on_page: :admin_users_create_step_6
    end
  end
end
