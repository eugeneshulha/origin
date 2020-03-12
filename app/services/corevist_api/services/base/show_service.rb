module CorevistAPI
  module Services
    class Base::ShowService < BaseServiceWithForm
      include BaseServiceInterface

      def perform
        object = object_class.find_by_id(@form.id)

        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        result(object)
      end
    end
  end
end
