describe 'salesdocs', type: :request do
  describe 'not available' do
    it 'before logged in' do
      order_number = "84631"
      get "/api/v1/salesdocs/#{order_number}", params: {format: :json}
      expect(body_errors).to include "You are not authorised to access this resource."
    end
  end

  describe 'show' do
    it 'returns valid order' do
      order_number = "84631"
      username = 'dummy_user'
      password = '123123123'

      # post '/api/v1/auth', params: {format: :json, user: {username: username, password: password}}
      # header = { Authorization: authorization_header}

      get "/api/v1/salesdocs/#{order_number}", params: {format: :json}, headers: generate_auth_header(username, password)
      assert_request_status_is(:success)
      expect(body.to_s).to include order_number
    end
  end

  # TODO from another Sold-to
  # TODO from another Sales Area
end
