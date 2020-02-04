#
# user details
#
module CorevistAPI
  class Forms::Admin::User::Step1 < CorevistAPI::Forms::BaseStep

      attr_accessor :user_id, :user_status, :first_name, :last_name, :email, :phone, :password, :confirm_password,
                    :microsite, :sso, :user_type, :language, :timezone, :number_format, :date_format, :time_format,
                    :classification
  end
end
