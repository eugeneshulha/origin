describe 'ping' do
  before {get '/api/v1/status'}
  it 'should be ok' do
    assert_request_status_is(:success)
    expect(body_status).to eq 'ok'
  end
end