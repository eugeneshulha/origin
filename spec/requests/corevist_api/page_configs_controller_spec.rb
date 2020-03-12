describe 'configs', type: :request do
  describe 'get configs for registration page' do
    before{get '/api/v1/page_configs/forgot_password_1'}
    # has translations, fields, buttonsData; Q: or just equal to json from /config/pages/passwords/new.json
    it 'return status code 200' do
      assert_request_status_is(:success)
      expect(status).to eq 200
      # TODO expect "translations", "fields", "buttonsData" in response
    end
  end


  # TODO login configs GET /api/v1/page_configs/login
  # TODO dashboard configs GET /api/v1/page_configs/dashboard
  # TODO registration configs GET /api/v1/page_configs/registration
  # TODO forgot password 1
  # TODO forgot password 2

end

