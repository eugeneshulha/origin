module CorevistAPI
  module Services::Base
    class UpdateService < CorevistAPI::Services::BaseServiceWithForm

      def perform
        object = object_class.find_by(id: @form.uuid)
        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }

        if depended_class.present? && @form.send(depended_key).present? && object.respond_to?(depended_key)
          object.send("#{depended_key}=", @form.send(depended_key))
        end

        object.updated_by = current_user.id if object.respond_to?(:updated_by)

        raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

        result(object)
      end
    end
  end
end
