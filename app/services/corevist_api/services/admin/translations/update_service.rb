module CorevistAPI
  module Services
    class Admin::Translations::UpdateService < CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        object = object_class.find_by_id(@form.uuid)
        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
        object.updated_by = current_user.id

        raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

        result(object)
      end

      def object_class
        CorevistAPI::Translation
      end
    end
  end
end
