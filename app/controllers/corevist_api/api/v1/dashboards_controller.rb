module CorevistAPI
  class API::V1::DashboardsController < API::V1::BaseController
    configs_for :new

    def navigation
      authorize(User)
      @result = service_for(:page_configs_navigation, performer_name, object: params).call

      render 'corevist_api/api/v1/shared/configs', result: @result
    end
  end
end
