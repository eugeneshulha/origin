#
# user details
#
module CorevistAPI
  module Forms::Admin::Users
    class Step1 < CorevistAPI::Forms::Admin::Users::BaseStep
      validate_component :admin_create_new_user_step_1, on_page: :admin_create_user, on_step: 1
    end
  end
end
