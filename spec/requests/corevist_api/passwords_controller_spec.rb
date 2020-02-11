describe 'Passwords', type: :request do
  describe 'forgot password' do
    describe 'get configs for registration page' do
      before{get '/api/v1/password/new'}
      # has translations, fields, buttonsData; Q: or just equal to json from /config/pages/passwords/new.json
      it 'return status code 200' do
        expect(response).to have_http_status(:success)
      end
    end



    describe 'full flow' do
      it 'requests reset password email' do
        skip
        # post '/api/v1/password' params: { user[username]: "user_1"}
      end
    end
    # post /api/v1/password with user[username] user_1, returns 200, message "Reset password instructions successfully sent"
    # extract password from sent email
    # get api/v1/password/edit?reset_password_token=#{token}
    # patch /api/v1/password with user[password] 123123123, user[password_confirmation] 123123123, user[reset_password_token] #{token}
    #
  end
end
