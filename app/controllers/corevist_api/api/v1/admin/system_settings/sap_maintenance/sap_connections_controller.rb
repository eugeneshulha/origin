module CorevistAPI
  module API::V1::Admin::SystemSettings::SAPMaintenance
    class SAPConnectionsController < API::V1::Admin::BaseController
      form_performer_for :index, :create, :update
      obj_performer_for :show, :destroy, :ping
      configs_for :index, :edit, :new
    end
  end
end
