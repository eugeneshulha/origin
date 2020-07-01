module CorevistAPI
  class API::V1::StatusesController < CorevistAPI::API::BaseController
    skip_before_action :authenticate_user!
    skip_before_action :establish_sap_connection

    def status
      res = {
          rails: :ok,
          mysql: ActiveRecord::Base.connected? ? :ok : :not_ok,
          sap: CorevistAPI::Context.current_connection&.ping ? :ok : :not_ok
      }
      render json: res, status: :ok
    end
  end
end
