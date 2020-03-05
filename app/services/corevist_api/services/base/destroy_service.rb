module CorevistAPI
  module Services
    class Base::DestroyService < BaseServiceWithForm
      include BaseServiceInterface

      def perform
        object = object_class.find_by_id(@form.id)

        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        object.destroy
        raise CorevistAPI::ServiceException.new(failed_destroy_msg) unless object.destroyed?

        result(object)
      end
    end
  end
end
