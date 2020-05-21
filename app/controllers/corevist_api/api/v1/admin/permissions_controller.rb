module CorevistAPI
  class API::V1::Admin::PermissionsController < API::V1::Admin::BaseController
    form_performer_for :index

    private

    def scope_model
      Permission
    end
  end
end