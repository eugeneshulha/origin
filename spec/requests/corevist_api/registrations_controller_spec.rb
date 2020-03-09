describe 'registrations', type: :request do
  describe 'configs' do
    before{get '/api/v1/registrations/new', params: {format: :json}}
    it 'return status code 200' do
      assert_request_status_is(:success)
    end
    # has translations, fields, buttonsData; Q: or just equal to json from /config/pages/registrations/new.json
  end

  # TODO valid case POST /api/v1/registrations
  # Parameters: {"user"=>{"first_name"=>"first name", "last_name"=>"last name", "microsite"=>"0", "email"=>"yury.matusevich@corevist.com", "phone"=>"123123123", "language"=>"en_US"}, "text/plain"=>[""]}
  #
  #
end
