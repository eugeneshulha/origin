module CorevistAPI
  module Services
    class Admin::Roles::UpdateService < BaseServiceWithForm
      MSG_ROLE_NOT_FOUND = 'api.roles.not_found'.freeze

      def perform
        object = CorevistAPI::Role.find_by_id(@form.id)
        return result.fail!(MSG_ROLE_NOT_FOUND) unless object

        fields(object).each { |field| object.public_send("#{field}=", @form.public_send(field)) }
        object.updated_by = current_user.id

        return result.fail!(object.errors.full_messages) unless object.save

        result(object)
      end
    end
  end
end
