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
        p = { 'username' => @params[:username].to_s }
        service_for("#{@params[:type]}_filter", @params[:scope], p).call
      end
    end
  end
end
