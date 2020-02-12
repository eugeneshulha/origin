module CorevistAPI
  class API::V1::StatusesController < CorevistAPI::API::BaseController
    skip_before_action :authenticate_user!

    def status
      render json: { status: :ok }, status: :ok
    end
  end
end
