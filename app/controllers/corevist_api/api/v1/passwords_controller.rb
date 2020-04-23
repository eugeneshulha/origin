module CorevistAPI
  class API::V1::PasswordsController < Devise::PasswordsController
    include CorevistAPI::Factories::FactoryInterface
    include CorevistAPI::ConfigsFor

    configs_for new: { authorize: false }
    respond_to :json


    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      @is_sent = successfully_sent?(resource)
    end

    def edit
      obj = Struct.new(:reset_password_token).new(params[:reset_password_token])
      @result = service_for(:page_configs_read, :forgot_password_2, object: obj).call
    end

    def update
      @form = form_for(:set_new_password, params)

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

    private

    def performer_name
      :forgot_password_1
    end
  end
end
