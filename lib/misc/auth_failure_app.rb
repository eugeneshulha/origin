class AuthFailureApp < Devise::FailureApp
  def http_auth_body
    {
        errors: [
            {
                status: 401,
                message: i18n_message
            }
        ]
    }.to_json
  end
end
