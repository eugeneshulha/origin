module CorevistAPI
  class API::V1::PasswordsController < Devise::PasswordsController
    include Configurable

    respond_to :json

    def new
      configs('passwords/new')
    end

    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      @is_sent = successfully_sent?(resource)
    end

    def edit
      configs('passwords/edit')
    end

    def update
      self.resource = resource_class.reset_password_by_token(resource_params)
      resource.unlock_access! if unlockable?(resource) if resource.errors.empty?
      render action: :update
    end
  end
end
