module CorevistAPI
  module Services::Base
    class DestroyService < CorevistAPI::Services::BaseService
      def call
        object = object_class.find_by_id(@params[:uuid])

        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        object.destroy
        raise CorevistAPI::ServiceException.new(failed_destroy_msg) unless object.destroyed?

        result(object)
      end
    end
  end
end
