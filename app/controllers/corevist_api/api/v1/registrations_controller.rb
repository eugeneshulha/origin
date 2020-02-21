module CorevistAPI
  class API::V1::RegistrationsController < CorevistAPI::API::V1::BaseController
    include CorevistAPI::Configurable
    skip_before_action :authenticate_user!

    def new
      configs('registrations/new')
    end

    def create
      form = CorevistAPI::Factories::FormsFactory.instance.for(:user_registration, params)
      service = CorevistAPI::Factories::ServicesFactory.instance.for(:user_registration, form, params)
      @result = service.call
    end
  end
end
