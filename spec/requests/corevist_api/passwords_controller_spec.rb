describe 'password', type: :request do


  context 'restore' do
    let!(:valid_password) {'123123123'}
    let!(:short_password) {'1'}
    let!(:long_password) {'12345678901234567890123456789012345678901234567890'}
    let!(:empty_password) {nil}

    def request_password_restore(input_data_hash)
      post '/api/v1/password', params: {format: :json, user: {username: input_data_hash[:username]}}
      assert_request_status_is(:success)
      expect(body_message).to eq 'Reset password instructions successfully sent'
    end

    def update_token(input, token)
      input[:params][:user][:reset_password_token] = token
    end

    def set_new_password(input_data_hash)
      patch '/api/v1/password', params: input_data_hash[:params]
      expect(response).to have_http_status(:success)
    end

    def manage_expectations(output)
      expect(body_status).to eq output[:status]
      expect(body_messages).to include output[:message] unless output[:message].empty?
      expect(body_errors).to include output[:error] unless output[:error].empty?
    end

    # DATA
    valid_input = {
        username: 'dummy_user',
        params:
            {
                format: :json,
                user:
                    {
                        password: '123123123', # valid_password,
                        password_confirmation: '123123123', # valid_password,
                        reset_password_token: ''
                    }
            }
    }
    valid_output = {
        status: 200,
        message: 'New password successfully set',
        error: ''
    }

    invalid_token_input = {
        username: 'dummy_user',
        params:
            {
                format: :json,
                user:
                    {
                        password: '123123123',
                        password_confirmation: '123123123',
                        reset_password_token: ''
                    }
            }
    }
    invalid_token_output = {
        status: 500,
        message: '',
        error: 'Reset password token is invalid'
    }

    not_matching_passowrds_input = {
        username: 'dummy_user',
        params:
            {
                format: :json,
                user:
                    {
                        password: '123123123',
                        password_confirmation: '123123123123',
                        reset_password_token: ''
                    }
            }
    }
    not_matching_passowrds_output = {
        status: 500,
        message: '',
        error: 'Password confirmation does not match'
    }

    empty_token_input = {
        username: 'dummy_user',
        params:
            {
                format: :json,
                user:
                    {
                        password: '123123123',
                        password_confirmation: '123123123',
                        reset_password_token: ''
                    }
            }
    }
    empty_token_output = {
        status: 500,
        message: '',
        error: 'Reset password token is blank'
    }

    short_password_input = {
        username: 'dummy_user',
        params:
            {
                format: :json,
                user:
                    {
                        password: '123',
                        password_confirmation: '123',
                        reset_password_token: ''
                    }
            }
    }
    short_password_output = {
        status: 500,
        message: '',
        error: 'Password value is too short'
    }

    long_password_input = {
        username: 'dummy_user',
        params:
            {
                format: :json,
                user:
                    {
                        password: '12345678901234567890123456789012345678901234567890',
                        password_confirmation: '12345678901234567890123456789012345678901234567890',
                        reset_password_token: ''
                    }
            }
    }
    long_password_output = {
        status: 500,
        message: '',
        error: 'Password value is too long'
    }

    empty_password_input = {
        username: 'dummy_user',
        params:
            {
                format: :json,
                user:
                    {
                        password: '',
                        password_confirmation: '',
                        reset_password_token: ''
                    }
            }
    }
    empty_password_output = {
        status: 500,
        message: '',
        error: 'Password field can not be blank'
    }

    describe 'with valid data' do
      it 'returns valid code and message' do
        request_password_restore(valid_input)
        update_token(valid_input, reset_password_token)
        set_new_password(valid_input)
        manage_expectations(valid_output)
      end
    end

    describe 'with invalid token' do
      it 'returns invalid token error message' do
        request_password_restore(invalid_token_input)
        update_token(invalid_token_input, 'invalid_token')
        set_new_password(invalid_token_input)
        manage_expectations(invalid_token_output)
      end
    end

    describe 'with not matching passwords' do
      it 'returns not matching passwords error message' do
        request_password_restore(not_matching_passowrds_input)
        update_token(not_matching_passowrds_input, reset_password_token)
        set_new_password(not_matching_passowrds_input)
        manage_expectations(not_matching_passowrds_output)
      end
    end

    describe 'with empty token' do
      it 'returns blank token error message' do
        request_password_restore(empty_token_input)
        update_token(empty_token_input, '')
        set_new_password(empty_token_input)
        manage_expectations(empty_token_output)
      end
    end

    describe 'with empty password' do
      it 'returns blank password error message' do
        request_password_restore(empty_password_input)
        update_token(empty_password_input, reset_password_token)
        set_new_password(empty_password_input)
        manage_expectations(empty_password_output)
      end
    end

    describe 'with short password' do
      it 'returns short password error message' do
        request_password_restore(short_password_input)
        update_token(short_password_input, reset_password_token)
        set_new_password(short_password_input)
        manage_expectations(short_password_output)
      end
    end

    describe 'with long password' do
      it 'returns long password error message' do
        request_password_restore(long_password_input)
        update_token(long_password_input, reset_password_token)
        set_new_password(long_password_input)
        manage_expectations(long_password_output)
      end
    end

    # case: password confirmation can't be empty
    # case: get forgot password 2 configs
  end
end
