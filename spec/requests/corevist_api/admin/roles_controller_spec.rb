describe 'Admin list roles request', type: :request do
  describe 'without sign in' do
    before{get '/api/v1/admin/roles', params: {format: :json}}
    it 'return status code 401' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'shows message valid error message' do
      expect(body_errors).to include "You are not authorised to access this resource."
    end
  end

  describe 'with sign in' do
    skip 'TODO'
  end
end
