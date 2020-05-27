module CorevistAPI
  module Services::Base
    class UpdateService < CorevistAPI::Services::BaseServiceWithForm

      def perform
        object = object_class.find_by_id(@form.id)
        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
        if %i[created_by updated_by].all? { |field| object.respond_to?(field) }
          object.created_by = object.updated_by = current_user.id
        end
        raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

        result(object)
      end
    end
  end
end
