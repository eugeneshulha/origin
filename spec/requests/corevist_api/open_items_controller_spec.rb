describe 'open items', type: :request do
  describe 'view' do
    it 'should return list of open items' do
      username = 'dummy_user'
      password = '123123123'

      get '/api/v1/open_items', params: {format: :json}, headers: generate_auth_header(username, password)
      assert_request_status_is(:success)
      expect(status).to eq 200
      expect(infos).to include "Open items have been loaded successfully"
    end
  end
end
