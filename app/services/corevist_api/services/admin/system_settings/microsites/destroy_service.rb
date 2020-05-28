module CorevistAPI
  module Services::Admin::SystemSettings::Microsites
    class DestroyService < CorevistAPI::Services::BaseService
      def call
        object = object_class.find_by_id(@params['uuid'])

        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        object.destroy
        raise CorevistAPI::ServiceException.new(failed_destroy_msg) unless object.destroyed?

        result(object)
      end

      def object_class
        CorevistAPI::Microsite
      end
    end
  end
end
