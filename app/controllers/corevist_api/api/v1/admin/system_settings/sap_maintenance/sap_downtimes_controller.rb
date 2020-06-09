module CorevistAPI
  module API::V1::Admin::SystemSettings::SAPMaintenance
    class SAPDowntimesController < API::V1::Admin::BaseController
      form_performer_for :index, :create, :update
      obj_performer_for :show, :destroy
      configs_for :index, :edit, :new
    end
  end
end
