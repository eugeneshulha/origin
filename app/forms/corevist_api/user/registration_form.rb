module CorevistAPI
  class User::RegistrationForm < CorevistAPI::BaseForm
    attr_accessor :first_name, :last_name, :email, :phone, :microsite, :language
    def params_key
      :user
    end
  end
end
