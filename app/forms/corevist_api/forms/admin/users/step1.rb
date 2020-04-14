#
# user details
#
module CorevistAPI
  module Forms::Admin
    module Users
      class Step1 < CorevistAPI::Forms::BaseForm
        validate_component :admin_create_new_user_step_1, on_page: :admin_users_create_step_1

        def params_key
          'user'
        end
      end
    end
  end
end
