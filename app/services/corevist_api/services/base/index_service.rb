module CorevistAPI
  module Services
    class Base::IndexService < CorevistAPI::Services::BaseServiceWithForm

      def perform
        filter_result = filter

        items = filter_by_query(filter_result.data)
        items = sort_by_param(items)
        data = paginate(items: items)

        result(data)
      end

      def filter
        service_for("#{@params[:type]}_filter", @params[:scope], @params[:filters]).call
      end
    end
  end
end
