module CorevistAPI
  module Services::Base
    class ShowService < CorevistAPI::Services::BaseService
      private

      def perform
        object = object_class.find_by(id: @params[:uuid])

        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        result(object)
      end
    end
  end
end
