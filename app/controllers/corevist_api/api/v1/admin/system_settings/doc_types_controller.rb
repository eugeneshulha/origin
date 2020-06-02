module CorevistAPI
  class API::V1::Admin::SystemSettings::DocTypesController < API::V1::BaseController
    form_performer_for :index, :create, :update
    obj_performer_for :show, :destroy
    configs_for :index, :edit, :new

    private

    def scope_model
      DocType
    end
  end
end
