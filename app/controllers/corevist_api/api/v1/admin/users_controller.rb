module CorevistAPI
  class API::V1::Admin::UsersController < API::V1::Admin::BaseController
    before_action :find_user, only: %i[show update destroy]

    def index
      authorize(User, :index?)
      @users = policy_scope(User)
    end

    def show; end

    def new
      authorize(User, :new?)
      step = "admin_users_step_#{params[:step]}".to_sym
      @step = FormsFactory.instance.for(step).validate!
    end

    def create
      authorize(User, :create?)
      @user = ServicesFactory.instance.for(:create_user).call
    end

    def edit
      authorize(User, :edit?)
    end

    def update; end

    def destroy
      @user.destroy
    end

    private

    def find_user
      @user = authorize(User.find_by(uuid: params[:id]))
    end
  end
end
