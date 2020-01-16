module CorevistAPI
  class API::V1::RegistrationsController < CorevistAPI::API::V1::BaseController
    skip_before_action :authenticate_user!

    def create
      form = FormsFactory.instance.for(:user_registration, params[:user])
      service = ServicesFactory.instance.for(:user_registration, form, params)
      @result = service.call
    end
  end
end
