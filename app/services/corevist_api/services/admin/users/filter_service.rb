module CorevistAPI
  module Services::Admin::Users
    class FilterService < CorevistAPI::Services::BaseService
      def call
        filter_result = CorevistAPI::Filters::UserFilter.new(current_user, @params, @object).run
        result(filter_result.data)
      end
    end
  end
end
