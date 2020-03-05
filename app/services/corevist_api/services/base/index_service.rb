module CorevistAPI
  module Services
    class Base::IndexService < BaseServiceWithForm
      include BaseServiceInterface

      def perform
        filter_result = filter
        result(filter_result.data)
      end

      def filter
        service_for("#{@params[:type]}_filter", @params[:scope], @params[:filters]).call
      end
    end
  end
end