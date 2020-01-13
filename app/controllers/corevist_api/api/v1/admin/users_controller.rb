module CorevistAPI
  class API::V1::Admin::UsersController < API::V1::Admin::BaseController
    before_action :find_user, only: [:destroy, :update, :show]

    def index
      @users = CorevistAPI::User.all
    end

    def show
    end

    def new
      step = "admin_users_step_#{params[:step]}".to_sym
      @step = CorevistAPI::FormsFactory.instance.for(step).validate!
    end

    def create
      @user = CorevistAPI::ServicesFactory.instance.for(:create_user).call
    end

    def edit
    end

    def update
    end

    def destroy
      @user.destroy
    end

    private

    def find_user
      @user = CorevistAPI::User.find_by(uuid: params[:id])
    end
  end
end
