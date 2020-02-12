module CorevistAPI
  module API::V1
    class PartnersController < BaseController
      def index
        perform_action(:search)
      end
    end
  end
end
