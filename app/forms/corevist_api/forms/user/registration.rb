module CorevistAPI
  class Forms::User::Registration < CorevistAPI::Forms::BaseForm
    include CorevistAPI::FormValidations

    def params_key
      :user
    end
  end
end
