module CorevistAPI
  module Forms
    module Admin::Users::Partners
      class IndexForm < CorevistAPI::Forms::BaseForm
        validate_component :user_partners_form, on_page: :admin_users_partners_index
      end
    end
  end
end
