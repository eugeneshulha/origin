module CorevistAPI
  module Services::Base
    class CreateService < CorevistAPI::Services::BaseServiceWithForm

      def perform
        object = object_class.new
        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }

        if depended_class.present? && @form.send(depended_key).present? && object.respond_to?(depended_key)
          object.send("#{depended_key}=", depended_class.where(id: @form.send(depended_key)))
        end

        if %i[created_by updated_by].all? { |field| object.respond_to?(field) }
          object.created_by = object.updated_by = current_user.id
        end

        raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

        result(object)
      end
    end
  end
end
