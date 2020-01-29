module CorevistAPI
  class API::V1::PasswordsController < Devise::PasswordsController
    include Configurable

    respond_to :json

    def create
      binding.pry
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      @is_sent = successfully_sent?(resource)
    end

    def edit; end

    private

    def self.config_file_name
      'forgot_password'
    end
  end
end
