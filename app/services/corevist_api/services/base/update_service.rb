module CorevistAPI
  module Services::Base
    class UpdateService < CorevistAPI::Services::BaseServiceWithForm

      def perform
        object = object_class.find_by(id: @form.uuid)
        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
        return result(object, message: did_not_change) unless object.changed?

        object.updated_by = current_user.id if object.respond_to?(:updated_by)

        raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

        result(object)
      end
    end
  end
end
