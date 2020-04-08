module CorevistAPI
  class API::V1::Admin::RolesController < API::V1::Admin::BaseController
    form_performer_for :index, :show, :create, :update, :destroy
    configs_for :index, :show

    private

    def scope_model
      Role
    end
  end
end
