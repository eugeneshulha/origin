module CorevistAPI::Services::Admin::Roles
  class FilterService < CorevistAPI::Services::BaseService
    def call
      filter_result = CorevistAPI::Filters::RoleFilter.new(@params, @object).run
      result(filter_result.data)
    end
  end
end
