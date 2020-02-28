describe 'Invoices', type: :request do
  describe 'not available' do
    it 'before logged in' do
      invoice_number = "90039831"
      get "/api/v1/invoices/#{invoice_number}", params: {format: :json}
      expect(body_errors).to include "You are not authorised to access this resource."
    end
  end

  describe 'show' do
    it 'returns valid invoice' do
      invoice_number = "90039831"
      username = 'dummy_user'
      password = '123123123'

      post '/api/v1/auth', params: {format: :json, user: {username: username, password: password}}
      header = { Authorization: authorization_header}
      get "/api/v1/invoices/#{invoice_number}", params: {format: :json}, headers: header
      assert_request_status_is(:success)
      expect(body.to_s).to include invoice_number
    end

    it 'returns valid debit memo' do
      invoice_number = "90039829"
      username = 'dummy_user'
      password = '123123123'

      post '/api/v1/auth', params: {format: :json, user: {username: username, password: password}}
      header = { Authorization: authorization_header}
      get "/api/v1/invoices/#{invoice_number}", params: {format: :json}, headers: header
      assert_request_status_is(:success)
      expect(body.to_s).to include invoice_number
    end

    # TODO from another Sold-to
    # TODO from another Sales Area
  end
end
