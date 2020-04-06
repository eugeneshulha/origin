module CorevistAPI
  module API::V1
    class Admin::UsersController < Admin::BaseController
      before_action :authorize_user, only: %i[index show create update destroy]
      before_action :check_step, only: :create
      before_action :perform_action, only: %i[index show create update destroy]

      configs_for :new, :index_configs, :edit

      STEPS = %w[1 2 3 4 5 6].freeze

      def index; end

      def show; end

      def create; end

      def update; end

      def destroy; end

      private

      def type
        return "#{action_prefix}_#{action_name}".to_sym if params[:step].blank?

        "#{action_prefix}_step_#{params[:step]}".to_sym
      end

      def check_step
        error('api.errors.step') if STEPS.exclude?(params[:step].to_s&.strip)
      end

      def scope_model
        User
      end
    end
  end
end
