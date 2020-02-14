describe 'Admin list partners request', type: :request do
  describe 'without sign in' do
    before{get '/api/v1/partners', params: {format: :json}}
    it 'return status code 401' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'shows message valid error message' do
      response_hash = JSON.parse response.body
      # TODO instead of error message expect it called by the Devise
      # from /Users/andreiklepets/projects/corevist_api/config/locales/devise.en_US.yml
      expect(response_hash["errors"].first["message"]).to eq "You need to sign in or sign up before continuing."
    end
  end

  describe 'with sign in' do
    skip 'TODO'
  end
end
