module CorevistAPI
  class Forms::Admin::Users::BaseStep < CorevistAPI::Forms::BaseForm
    def params_key
      :user
    end
  end
end
