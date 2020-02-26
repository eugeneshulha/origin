module CorevistAPI
  module API::V1
    class PartnersController < BaseController
      before_action :perform_action, only: %i[index]

      def index; end

      private

      def type
        "#{action_prefix}_search".to_sym
      end
    end
  end
end
