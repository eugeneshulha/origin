module CorevistAPI
  class API::V1::Salesdocs::QuestionsController < API::V1::BaseController
    configs_for :new
    form_performer_for :create
  end
end
