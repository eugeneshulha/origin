describe 'Admin list partners request', type: :request do
  describe 'without sign in' do
    before{get '/api/v1/partners', params: {format: :json}}
    it 'return status code 401' do
      assert_request_status_is(:unauthorized)
    end

    it 'shows message valid error message' do
      # TODO instead of error message expect it called by the Devise
      # from /Users/andreiklepets/projects/corevist_api/config/locales/devise.en_US.yml
      expect(body_errors).to include "You are not authorised to access this resource."
    end
  end

  describe 'with sign in' do
    skip 'TODO'
  end
end
