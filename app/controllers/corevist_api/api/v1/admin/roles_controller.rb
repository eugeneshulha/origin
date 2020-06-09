module CorevistAPI
  class API::V1::Admin::RolesController < API::V1::Admin::BaseController
    form_performer_for :index, :create, :update
    obj_performer_for :show, :destroy
    configs_for :index, :edit, :new

    private

    def scope_model
      Role
    end
  end
end
