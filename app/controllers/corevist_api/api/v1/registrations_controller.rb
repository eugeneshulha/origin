module CorevistAPI
  class API::V1::RegistrationsController < CorevistAPI::API::V1::BaseController
    skip_before_action :authenticate_user!

    def new
      @result = service_for(:page_configs_read, :registration).call
    end

    def create
      form = form_for(:user_registration, params)
      service = service_for(:user_registration, form, params)
      @result = service.call
    end
  end
end
