module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes
    class CreateService < CorevistAPI::Services::Base::CreateService
      def perform
        object = object_class.new
        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }

        raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

        result(object)
      end

      private

      def object_class
        CorevistAPI::SAPDowntime
      end
    end
  end
end
