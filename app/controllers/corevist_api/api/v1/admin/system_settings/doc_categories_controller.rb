module CorevistAPI
  class API::V1::Admin::SystemSettings::DocCategoriesController < API::V1::Admin::BaseController
    form_performer_for :index
    configs_for :index

    private

    def scope_model
      DocCategory
    end
  end
end
