describe 'ping' do
  before {get '/api/v1/status'}
  it 'should be ok' do
    expect(response).to have_http_status(:success)
    response_hash = JSON.parse response.body
    expect(response_hash["status"]).to eq 'ok'
  end
end