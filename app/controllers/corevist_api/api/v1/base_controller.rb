module CorevistAPI
  class API::V1::BaseController < API::BaseController
    before_action :authenticate_api_user!
  end
end
