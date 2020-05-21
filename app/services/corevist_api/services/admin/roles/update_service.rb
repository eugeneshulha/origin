module CorevistAPI
  module Services
    class Admin::Roles::UpdateService < CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        object = object_class.find_by(id: @form.uuid)
        raise CorevistAPI::ServiceException.new(not_found_msg) unless object

        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
        object.permissions = CorevistAPI::Permission.where(id: @form.permissions) if @form.permissions.present?
        object.updated_by = current_user.id

        raise CorevistAPI::ServiceException.new(object.errors.full_messages) unless object.save

        result(object)
      end

      def object_class
        CorevistAPI::Role
      end
    end
  end
end
