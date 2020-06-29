module CorevistAPI
  class API::V1::PaymentsController < API::V1::BaseController
    form_performer_for :index
    obj_performer_for :show
    configs_for :index, :show
  end
end
