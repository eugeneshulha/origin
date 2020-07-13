module CorevistAPI
  class API::V1::Carts::ItemsController < API::V1::BaseController
    form_performer_for :index, :create, :update
    obj_performer_for :destroy
  end
end
