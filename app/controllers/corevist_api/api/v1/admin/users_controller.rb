module CorevistAPI
  module API::V1
    class Admin::UsersController < Admin::BaseController
      include CorevistAPI::ActionPerformer

      before_action :find_user, only: %i[show update destroy]
      before_action :authorize_user, only: %i[index new create edit]

      STEPS = %w[1 2 3 4 5 6].freeze

      def index
        @users = filter_users(policy_scope(User))
      end

      def show; end

      def new
        step = "admin_users_step_#{params[:step]}".to_sym
        @result = FormsFactory.instance.for(step).validate!
      end

      def create
        return error('api.errors.step') if STEPS.exclude?(params[:step])

        @result = service_result
        error(@result.errors) if @result.failed?
      end

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

      def filter_users(users_scope)
        return users_scope unless params[:filters].present?

        result = ServicesFactory.instance.for(:filter_user, current_user, params[:filters], users_scope).call
        result.successful? ? result.data : []
      end

      def type
        "#{action_prefix}_step_#{params[:step]}".to_sym
      end
    end
  end
end
