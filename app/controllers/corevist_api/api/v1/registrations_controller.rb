module CorevistAPI
  class API::V1::RegistrationsController < CorevistAPI::API::V1::BaseController
    include CorevistAPI::Configurable
    skip_before_action :authenticate_user!

    def create
      form = FormsFactory.instance.for(:user_registration, params[:user])
      service = ServicesFactory.instance.for(:user_registration, form, params)
      @result = service.call
    end

    private

    def self.config_file_name
      'registrations'
    end
  end
end
