module CorevistAPI::Web::Admin
  class DashboardsController < CorevistAPI::Web::BaseController
    before_action :authenticate_web_user!

    def index
    end
  end
end
