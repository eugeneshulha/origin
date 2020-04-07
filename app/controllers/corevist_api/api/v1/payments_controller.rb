module CorevistAPI
  class API::V1::PaymentsController < API::V1::BaseController
    configs_for :new
    form_performer_for :create
  end
end
