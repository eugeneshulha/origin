module CorevistAPI
  module Services::Base
    class ShowService < CorevistAPI::Services::BaseService
      def call
        object = object_class.find_by_id(@params[:uuid])

        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        result(object)
      end
    end
  end
end
