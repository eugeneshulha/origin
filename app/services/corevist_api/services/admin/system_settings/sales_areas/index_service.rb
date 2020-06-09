module CorevistAPI::Services::Admin::SystemSettings::SalesAreas
  class IndexService < CorevistAPI::Services::Base::IndexService
    def perform

      items = sort_by_param(filter_by_query(CorevistAPI::SalesArea.all))
      data = paginate(items: items)

      result(data)
    end
  end
end
