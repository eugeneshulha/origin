module CorevistAPI::Services::Admin::Users
  class FilterService < CorevistAPI::Services::BaseService
    private

    def perform
      filter_result = CorevistAPI::Filters::UserFilter.new(current_user, @params, @object).run
      result(filter_result.data)
    end
  end
end
