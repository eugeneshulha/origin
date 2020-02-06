module CorevistAPI
  class Forms::User::Registration < CorevistAPI::Forms::BaseForm
    attr_accessor :first_name, :last_name, :email, :phone, :microsite, :language

    validates_presence_of :first_name, :last_name, :email, :phone, :microsite, :language,

    def params_key
      :user
    end
  end
end
