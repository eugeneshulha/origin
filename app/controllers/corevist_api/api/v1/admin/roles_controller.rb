module CorevistAPI
  class API::V1::Admin::RolesController < API::V1::Admin::BaseController
    before_action :find_role, only: %i[show update destroy]

    def index
      @roles = CorevistAPI::Role.all
    end

    def show; end

    def create
      action = CorevistAPI::FormsFactory.instance.for(:admin_roles_create)
      @result = CorevistAPI::ServicesFactory.instance.for(:create_role, action).call
    end

    def update; end

    def destroy
      @role.destroy
    end

    private

    def find_role
      @role = CorevistAPI::Role.find_by(id: params[:id])
    end
  end
end
