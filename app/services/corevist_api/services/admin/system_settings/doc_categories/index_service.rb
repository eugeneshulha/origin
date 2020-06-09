module CorevistAPI::Services::Admin::SystemSettings::DocCategories
  class IndexService < CorevistAPI::Services::Base::IndexService
    private

    def filter
      result(CorevistAPI::DocCategory.all)
    end
  end
end
