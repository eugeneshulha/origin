module CorevistAPI
  module Services
    class Base::UpdateService < BaseServiceWithForm
      include BaseServiceInterface

      def perform
        object = object_class.find_by_id(@form.id)
        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
        object.updated_by = current_user.id

        raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

        result(object)
      end
    end
  end
end
