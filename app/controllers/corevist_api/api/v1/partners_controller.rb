module CorevistAPI
  module API::V1
    class PartnersController < BaseController
      form_performer_for :index
      configs_for :new
    end
  end
end
