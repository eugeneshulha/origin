describe 'Admin list users request', type: :request do
  describe 'without sign in' do
    before {get '/api/v1/admin/users', params: {format: :json}}
    it 'return status code 401' do
      assert_request_status_is(:unauthorized)
      # expect(response).to have_http_status(:unauthorized)
    end

    it 'shows message valid error message' do
      expect(body_errors).to include "You are not authorised to access this resource."
    end
  end

  describe 'with sign in' do
    skip 'TODO'
  end
end
