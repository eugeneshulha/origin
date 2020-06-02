module CorevistAPI::Services::Admin::SystemSettings::DocCategories
  class IndexService < CorevistAPI::Services::Base::IndexService
    def perform
      items = sort_by_param(filter_by_query(CorevistAPI::DocCategory.all))

      result(paginate(items: items))
    end
  end
end
