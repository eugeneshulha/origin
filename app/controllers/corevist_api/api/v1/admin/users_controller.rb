module CorevistAPI
  module API::V1
    class Admin::UsersController < Admin::BaseController
      before_action :find_user, only: %i[show update destroy]

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
        authorize(User)
        step = "admin_users_step_#{params[:step]}".to_sym
        @result = FormsFactory.instance.for(step).validate!
        @user = ServicesFactory.instance.for(:create_user).call
      end

      def edit
        authorize(User)
      end

      def update; end

      def destroy
        @user.destroy
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
