module CorevistAPI
  module Services
    class Admin::Roles::FilterService < BaseService
      def call
        filter_result = CorevistAPI::Filters::RoleFilter.new(@params, @object).run
        result(filter_result.data)
      end
    end
  end
end
