module CorevistAPI
  module Services
    class Admin::Roles::IndexService < BaseServiceWithForm
      def perform
        filter_result = filter_roles
        return result.fail!(filter_result.errors) if filter_result.failed?

        result(filter_result.data)
      end

      def filter_roles
        service_for("#{@params[:type]}_filter", @params[:scope], @params[:filters]).call
      end
    end
  end
end
