# require 'spec/rails_helper'
describe 'sessions', type: :request do
  describe 'login configs' do
    before{get '/api/v1/auth/configs', params: {format: :json}} # find a way to enter correct format
    it 'return status code 200' do
      assert_request_status_is(:success)
    end
    #   get /api/v1/auth/configs returns 200, has translations, fields, buttonsData; Q: maybe just equal to json from /config/pages/login.json
  end

  describe 'log in' do
    test_username = 'dummy_user'
    before {post '/api/v1/auth', params: {format: :json, user: {username: test_username, password: '123123123'}}}
    it 'is successful' do
      assert_request_status_is(:success)
      # TODO instead of message expect it called by the Devise from /Users/andreiklepets/projects/corevist_api/config/locales/devise.en_US.yml
      expect(body_infos).to include "Signed in successfully."
      expect(body_data["account_id"]).to eq CorevistAPI::User.find_or_initialize_by(username: test_username).uuid
    end
  end

  # TODO all negative cases
  # TODO log out
end
