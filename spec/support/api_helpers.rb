module ApiHelpers

  def status
    response.status
  end

  def headers
    response.headers
  end

  def infos
    body['infos']
  end

  def data
    body['data']
  end

  def authorization_header
    headers["Authorization"]
  end

  def body  #was json
    JSON.parse(response.body)
  end

  def body_data
    body["data"]
  end

  def body_message
    body["message"]
  end

  def body_messages
    body["messages"]
  end

  def body_status
    body["status"]
  end

  def body_errors
    body["errors"]
  end

  def body_infos
    body["infos"]
  end

  def last_email_body
    ActionMailer::Base.deliveries.last.body.to_s
  end

  def reset_password_token
    last_email_body.match(/token=(.*)\">/)[1]
  end

  def assert_request_status_is(status)
    expect(response).to have_http_status(status)
  end

  def generate_auth_header(username, password)
    post '/api/v1/auth', params: {format: :json, user: {username: username, password: password}}
    { Authorization: authorization_header}
  end

end