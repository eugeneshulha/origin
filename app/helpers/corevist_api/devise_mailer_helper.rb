module CorevistAPI
  module DeviseMailerHelper
    def react_edit_password_url(resource, options = {})
      "#{Settings.self_url}/forgot_password/reset?reset_password_token=#{options[:reset_password_token]}"
    end
  end
end
