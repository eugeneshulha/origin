module CorevistAPI::Services
  class Base::IndexService < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      filter_result = filter

      items = filter_by_query(filter_result.data)
      items = sort_by_param(items)
      data = paginate(items: items)

      result(data)
    end
  end
end
