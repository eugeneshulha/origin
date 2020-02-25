class AuthFailureApp < Devise::FailureApp
  def http_auth_body
    {
        status: 401,
        errors: [
            i18n_message
        ]
    }.to_json
  end
end
