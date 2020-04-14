#
# assigned sold tos
#
module CorevistAPI
  module Forms
    class Admin::Users::Step4 < CorevistAPI::Forms::BaseForm
      validate_component :sold_tos_of_new_user_form, on_page: :admin_users_create_step_4
    end
  end
end
