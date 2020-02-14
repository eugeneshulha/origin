# require 'spec/rails_helper'
describe 'Sessions', type: :request do
  describe 'login configs' do
    before{get '/api/v1/auth/configs', params: {format: :json}}
    it 'return status code 200' do
      expect(response).to have_http_status(:success)
    end
    #   get /api/v1/auth/configs returns 200, has translations, fields, buttonsData; Q: maybe just equal to json from /config/pages/login.json
  end

  describe 'log in' do
    test_username = 'dummy_user'
    before {post '/api/v1/auth', params: {format: :json, user: {username: test_username, password: '123123123'}}}
    it 'successful' do
      expect(response).to have_http_status(:success)
      response_hash = JSON.parse response.body
      # TODO instead of message expect it called by the Devise from /Users/andreiklepets/projects/corevist_api/config/locales/devise.en_US.yml
      expect(response_hash["infos"]).to include "Signed in successfully."
      expect(response_hash["data"]["account_id"]).to eq CorevistAPI::User.find_or_initialize_by(username: test_username).uuid
    end
  end
end
