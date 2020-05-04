module CorevistAPI
  class API::V1::OpenItemsController < API::V1::BaseController
    form_performer_for :index
    configs_for :index
  end
end
