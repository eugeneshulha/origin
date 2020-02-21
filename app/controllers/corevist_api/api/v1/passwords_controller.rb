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
      @form = CorevistAPI::Factories::FormsFactory.instance.for(:set_new_password, params)

      if @form.valid?
        self.resource = resource_class.reset_password_by_token(resource_params)
        if resource.errors.empty?
          resource.unlock_access! if unlockable?(resource)
        else
          @form = resource
        end
      end

      render action: :update
    end
  end
end
