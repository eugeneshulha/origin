#
# user details
#
module CorevistAPI
  module Forms::Admin
    module Users
      class Step1 < CorevistAPI::Forms::BaseForm
        validate_component :admin_create_new_user_step_1, on_page: :admin_create_user, on_step: 1
      end
    end
  end
end
