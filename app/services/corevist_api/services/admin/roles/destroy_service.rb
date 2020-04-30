module CorevistAPI
  module Services
    class Admin::Roles::DestroyService < CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        object = object_class.find_by_id(id: @form.uuid)

        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        object.destroy
        raise CorevistAPI::ServiceException.new(failed_destroy_msg) unless object.destroyed?

        result(object)
      end

      def object_class
        CorevistAPI::Role
      end
    end
  end
end
