module CorevistAPI
  class API::V1::AccountsController < API::V1::BaseController
    configs_for :edit
    form_performer_for :update
    obj_performer_for :show

    skip_before_action :establish_sap_connection

    private

    def scope_model
      CorevistAPI::User
    end
  end
end
