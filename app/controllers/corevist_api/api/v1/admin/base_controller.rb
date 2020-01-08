module CorevistAPI
  class API::V1::Admin::BaseController < API::BaseController
    before_action :authenticate_admin!


    private

      def authenticate_admin!
      end
  end
end
