module CorevistAPI
  module Forms
    class Admin::Users::Partners::DestroyForm < CorevistAPI::Forms::BaseForm
      validate_component :destroy_users_partners_form, on_page: :admin_users_partners_destroy
    end
  end
end
