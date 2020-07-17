module CorevistAPI::Services::Admin::Themes
  class FilterService < CorevistAPI::Services::BaseService
    private

    def perform
      filter_result = CorevistAPI::Filters::RoleFilter.new(@params, @object).run
      result(filter_result.data)
    end
  end
end
