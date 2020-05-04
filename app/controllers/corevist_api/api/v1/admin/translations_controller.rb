module CorevistAPI
  class API::V1::Admin::TranslationsController < API::V1::Admin::BaseController
    form_performer_for :index, :create, :update, :destroy
    configs_for :index, :new, :edit
  end
end
