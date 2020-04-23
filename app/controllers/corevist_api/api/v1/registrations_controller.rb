module CorevistAPI
  class API::V1::RegistrationsController < CorevistAPI::API::V1::BaseController
    skip_before_action :authenticate_user!
    configs_for new: { authorize: false }

    def create
      form = form_for(:user_registration, params)
      service = service_for(:user_registration, form, params)
      @result = service.call
    end
  end
end
