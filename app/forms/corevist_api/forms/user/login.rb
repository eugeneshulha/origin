module CorevistAPI
  module Forms::User
    class Login < CorevistAPI::Forms::BaseForm
      include FormValidations

      def params_key
        :user
      end
    end
  end
end
