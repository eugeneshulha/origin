module CorevistAPI
  class API::V1::Admin::RolesController < API::V1::Admin::BaseController
    before_action :authorize_user, only: %i[index show create update destroy]
    before_action :perform_action, only: %i[index show create update destroy]

    def index; end

    def show; end

    def create; end

    def update; end

    def destroy; end

    private

    def type
      "#{action_prefix}_#{action_name}".to_sym
    end

    def scope_model
      Role
    end
  end
end
