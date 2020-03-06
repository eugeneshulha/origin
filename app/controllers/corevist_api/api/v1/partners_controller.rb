module CorevistAPI
  module API::V1
    class PartnersController < BaseController
      before_action :perform_action, only: %i[index]

      def index; end

      def new
        @result = service_for(:page_configs_read, :partner_search_modal).call
      end

      private

      def type
        "#{action_prefix}_search".to_sym
      end
    end
  end
end
