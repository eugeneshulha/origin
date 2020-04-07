module CorevistAPI
  module API::V1
    class Admin::UsersController < Admin::BaseController
      before_action :check_step, only: :create

      form_performer_for :index, :show, :create, :update, :destroy
      configs_for :new, :index, :edit

      STEPS = %w[1 2 3 4 5 6].freeze

      private

      def performer_name
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
