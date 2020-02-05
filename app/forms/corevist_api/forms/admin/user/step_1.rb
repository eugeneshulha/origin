#
# user details
#
module CorevistAPI
  class Forms::Admin::User::Step1 < CorevistAPI::Forms::Admin::User::BaseStep

    attr_accessor :user_id, :first_name, :last_name, :email, :phone, :password, :confirm_password,
                  :microsite_id, :user_type_id, :language, :timezone, :number_format, :date_format, :time_format,
                  :user_classification_id


    def validate!
    end
  end
end
