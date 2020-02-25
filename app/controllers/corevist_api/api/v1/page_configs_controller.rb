module CorevistAPI
  class API::V1::PageConfigsController < CorevistAPI::API::V1::BaseController
    skip_before_action :authenticate_user!, if: :allow_to_access_configs

    def show
      service = service_for(:page_configs_read, params)
      @result = service.call
    end

    private

    def allow_to_access_configs
      should_authorize_configs_for?(params[:page_id])
    end
  end
end
