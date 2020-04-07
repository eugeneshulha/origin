module CorevistAPI
  module API::V1
    class PartnersController < BaseController
      form_performer_for :index
      configs_for :new

      def index; end

      private

      def performer_name
        "#{action_prefix}_search".to_sym
      end
    end
  end
end
