module CorevistAPI
  class API::V1::CartsController < API::V1::BaseController
    form_performer_for :create, :update, :submit
    obj_performer_for :destroy, :get_last_active
  end
end
