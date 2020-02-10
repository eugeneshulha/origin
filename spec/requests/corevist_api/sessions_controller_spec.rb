describe 'Sessions', type: :request do
  describe 'login configs' do
    before{get '/api/v1/auth/configs', params: {format: :json}}
    it 'return status code 200' do
      expect(response).to have_http_status(:success)
    end
    #   get /api/v1/auth/configs returns 200, has translations, fields, buttonsData; Q: maybe just equal to json from /config/pages/login.json
  end
end
