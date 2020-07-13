module CorevistAPI
  class API::V1::Carts::ItemsController < API::V1::BaseController
    form_performer_for :create, :update
    obj_performer_for :index, :destroy
  end
end
