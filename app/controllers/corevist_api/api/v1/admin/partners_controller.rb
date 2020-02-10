module CorevistAPI
  module API::V1
    class Admin::PartnersController < Admin::BaseController
      def index
        perform_action(:search)
      end
    end
  end
end
