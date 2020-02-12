module CorevistAPI
  module API::V1
    class Admin::UsersController < Admin::BaseController
      include CorevistAPI::ActionPerformer

      before_action :find_user, only: %i[show update destroy]

      STEPS = %w[1 2 3 4 5 6].freeze

      def index
        authorize(User)
        @users = filter_users(policy_scope(User))
      end

      def show; end

      def new
        authorize(User)
        step = "admin_users_step_#{params[:step]}".to_sym
        @result = FormsFactory.instance.for(step).validate!
      end

      def create
        return error('api.errors.step') if STEPS.exclude?(params[:step])

        authorize(User)
        type = "#{action_prefix}_step_#{params[:step]}".to_sym
        form = form_for(type, params)
        @result = service_for(type, form, params).call
        error(@result.errors) if @result.failed?
      end

      def edit
        authorize(User)
      end

      def update; end

      def destroy
        @user.destroy
      end

      def params
        return super if current_user.blank? || super[:user].blank?

        super.tap { |params| params[:user][CURRENT_USER_ID_KEY] = current_user.id }
      end

      private

      def find_user
        return entry_not_found(:user) if (user = User.find_by_uuid(params[:uuid])).blank?

        @user = authorize(user)
      end

      def filter_users(users_scope)
        return users_scope unless params[:filters].present?

        result = ServicesFactory.instance.for(:filter_user, current_user, params[:filters], users_scope).call
        result.successful? ? result.data : []
      end
    end
  end
end
