module CorevistAPI
  module API::V1
    class Admin::UsersController < Admin::BaseController
      before_action :find_user, only: %i[show update destroy]
      before_action :authorize_user, only: %i[index new create edit]
      before_action :check_step, only: :create
      before_action :perform_action, only: %i[index create]

      STEPS = %w[1 2 3 4 5 6].freeze

      def index; end

      def show; end

      def new
        step = "admin_users_step_#{params[:step]}".to_sym
        @result = FormsFactory.instance.for(step).validate!
      end

      def create; end

      def edit; end

      def update; end

      def destroy
        @user.destroy
      end

      private

      def find_user
        return error('api.errors.user_not_found') unless (user = User.find_by_uuid(params[:uuid]))

        @user = authorize(user)
      end

      def type
        return "#{action_prefix}_#{action_name}".to_sym if params[:step].blank?

        "#{action_prefix}_step_#{params[:step]}".to_sym
      end

      def check_step
        error('api.errors.step') if STEPS.exclude?(params[:step])
      end

      def scope_model
        User
      end
    end
  end
end
