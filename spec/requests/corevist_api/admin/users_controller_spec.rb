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

  # TODO show users /api/v1/admin/users?filters[username]=user_1&filters[last_name]=Last
  # requires authorization
  #
  # TODO show user /api/v1/admin/users/b8488dac-d4be-4cfd-a197-6049a230aa0e
  # requires authorization
  #
  # TODO destroy user /api/v1/admin/users/8bb30395-de2a-42fd-8d5e-a8bee209e0da
  # requires authorization
  #
  # TODO patch user /api/v1/admin/users/1a92499c-f1be-424c-91c2-930d68a91010
  # requires authorization
  #
  # TODO create user 6 steps
  #
end
