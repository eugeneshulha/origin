module CorevistAPI
  class API::V1::DashboardsController < API::V1::BaseController
    def new
      @result = service_for(:page_configs_read, :dashboard).call
    end
  end
end
