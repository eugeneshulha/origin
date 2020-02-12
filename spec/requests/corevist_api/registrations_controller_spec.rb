describe 'Registrations', type: :request do
  describe 'configs' do
    before{get '/api/v1/registrations/new', params: {format: :json}}
    it 'return status code 200' do
      expect(response).to have_http_status(:success)
    end
    # has translations, fields, buttonsData; Q: or just equal to json from /config/pages/registrations/new.json
  end
end