module CorevistAPI
  class Forms::User::Registration < CorevistAPI::Forms::BaseForm
    validate_component :registration_form, on_page: :registrations_new

    def params_key
      :user
    end
  end
end
