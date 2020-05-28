module CorevistAPI
  module Services::Admin::SystemSettings::Microsites
    class ShowService < CorevistAPI::Services::BaseService
      def call
        object = object_class.find_by_id(@params['uuid'])

        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        result(object)
      end

      def object_class
        CorevistAPI::Microsite
      end
    end
  end
end
