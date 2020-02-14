# require File.join(Rails.root, './../rails_helper.rb')
# require File.join(Rails.root, './../spec_helper.rb')
describe 'Passwords', type: :request do
  describe 'restore' do
    describe 'get configs for registration page' do
      before{get '/api/v1/password/new'}
      # has translations, fields, buttonsData; Q: or just equal to json from /config/pages/passwords/new.json
      it 'return status code 200' do
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["status"]).to eq 200
      end
    end

    describe 'with valid data' do
      test_username = 'dummy_user'
      password = '123123123'
      password_confirmation = '123123123'
      before {post '/api/v1/password', params: {format: :json, user: {username: test_username}}}
      it 'returns valid code and message' do
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["message"]).to eq "Reset password instructions successfully sent"
        last_email_body = ActionMailer::Base.deliveries.last.body.to_s
        reset_password_token = last_email_body.match(/token=(.*)\">/)[1]
        patch '/api/v1/password', params:
            {format: :json, user:
              {password: password,
               password_confirmation: password_confirmation,
               reset_password_token: reset_password_token}}
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["status"]).to eq 200
        expect(response_hash["messages"]).to include "New password successfully set"
      end
    end

    describe 'with not matching passwords' do
      test_username = 'dummy_user'
      password = '123123123'
      password_confirmation = '123123123'
      before {post '/api/v1/password', params: {format: :json, user: {username: test_username}}}
      it 'returns invalid token error message' do
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["message"]).to eq "Reset password instructions successfully sent"
        last_email_body = ActionMailer::Base.deliveries.last.body.to_s
        reset_password_token = last_email_body.match(/token=(.*)\">/)[1]
        patch '/api/v1/password', params:
            {format: :json, user:
                {password: password,
                 password_confirmation: password_confirmation,
                 reset_password_token: reset_password_token}}
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["status"]).to eq 200
        expect(response_hash["errors"]).to include "Reset password token is invalid"
      end
    end

    describe 'with wrong token' do
      test_username = 'dummy_user'
      password = '123123123'
      password_confirmation = '123123123'
      before {post '/api/v1/password', params: {format: :json, user: {username: test_username}}}
      it 'returns blank token error message' do
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["message"]).to eq "Reset password instructions successfully sent"
        # last_email_body = ActionMailer::Base.deliveries.last.body.to_s
        reset_password_token = ''
        patch '/api/v1/password', params:
            {format: :json, user:
                {password: password,
                 password_confirmation: password_confirmation,
                 reset_password_token: reset_password_token}}
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["status"]).to eq 500
        expect(response_hash["errors"]).to include "Reset password token is blank"
      end
    end

    describe 'with empty password' do
      test_username = 'dummy_user'
      password = ''
      password_confirmation = '123123123'
      before {post '/api/v1/password', params: {format: :json, user: {username: test_username}}}
      it 'returns blank password error message' do
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["message"]).to eq "Reset password instructions successfully sent"
        last_email_body = ActionMailer::Base.deliveries.last.body.to_s
        reset_password_token = last_email_body.match(/token=(.*)\">/)[1]
        patch '/api/v1/password', params:
            {format: :json, user:
                {password: password,
                 password_confirmation: password_confirmation,
                 reset_password_token: reset_password_token}}
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["status"]).to eq 500
        expect(response_hash["errors"]).to include "Password cannot be blank"
      end
    end

    describe 'with short password' do
      test_username = 'dummy_user'
      password = '1'
      password_confirmation = '123123123'
      before {post '/api/v1/password', params: {format: :json, user: {username: test_username}}}
      it 'returns short password error message' do
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["message"]).to eq "Reset password instructions successfully sent"
        last_email_body = ActionMailer::Base.deliveries.last.body.to_s
        reset_password_token = last_email_body.match(/token=(.*)\">/)[1]
        patch '/api/v1/password', params:
            {format: :json, user:
                {password: password,
                 password_confirmation: password_confirmation,
                 reset_password_token: reset_password_token}}
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["status"]).to eq 500
        # TODO find out the right error message
        # expect(response_hash["errors"]).to include "Password cannot be blank"
      end
    end

    describe 'with long password' do
      test_username = 'dummy_user'
      password = '1234567890123456789012345678901234567890'
      password_confirmation = '123123123'
      before {post '/api/v1/password', params: {format: :json, user: {username: test_username}}}
      it 'returns long password error message' do
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["message"]).to eq "Reset password instructions successfully sent"
        last_email_body = ActionMailer::Base.deliveries.last.body.to_s
        reset_password_token = last_email_body.match(/token=(.*)\">/)[1]
        patch '/api/v1/password', params:
            {format: :json, user:
                {password: password,
                 password_confirmation: password_confirmation,
                 reset_password_token: reset_password_token}}
        expect(response).to have_http_status(:success)
        response_hash = JSON.parse response.body
        expect(response_hash["status"]).to eq 500
        # TODO find out the right error message
        # expect(response_hash["errors"]).to include "Password cannot be blank"
      end
    end

    # case: get forgot password 2 configs
  end
end
