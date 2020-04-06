module CorevistAPI
  module Services
    class Base::IndexService< CorevistAPI::Services::BaseServiceWithForm

      def perform
        filter_result = filter

        data = paginate(users: filter_result.data)

        result(data)
      end

      def filter
        service_for("#{@params[:type]}_filter", @params[:scope], @params[:filters]).call
      end
    end
  end
end
