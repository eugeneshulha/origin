module CorevistAPI
  class API::V1::OpenItemsController < API::V1::BaseController
    form_performer_for :index, :create
    configs_for :index, :new
  end
end
