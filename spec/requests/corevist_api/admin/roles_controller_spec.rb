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

  # TODO show roles /api/v1/admin/roles
  # requires auth
  #
  # TODO create role POST /api/v1/admin/roles
  # requires auth
  #
  # TODO update role PATCH /api/v1/admin/roles/2
  # requires auth
  #
  # TODO show role GET /api/v1/admin/roles/1
  # requires auth
  #
  # TODO destroy role /api/v1/admin/roles/2
  # requires auth
  #
  #
  #
  #
end
