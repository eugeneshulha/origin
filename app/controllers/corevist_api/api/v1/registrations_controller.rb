module CorevistAPI
  class API::V1::RegistrationsController < CorevistAPI::API::V1::BaseController
    skip_before_action :authenticate_user!

    def new
      @result = service_for(:page_configs_read, :registration).call
    end

    def create
      form = CorevistAPI::Factories::FormsFactory.instance.for(:user_registration, params)
      service = CorevistAPI::Factories::ServicesFactory.instance.for(:user_registration, form, params)
      @result = service.call
    end
  end
end
