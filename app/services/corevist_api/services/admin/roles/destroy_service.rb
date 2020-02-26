module CorevistAPI
  module Services
    class Admin::Roles::DestroyService < BaseServiceWithForm
      MSG_ROLE_NOT_FOUND = 'api.roles.not_found'.freeze
      MSG_ROLE_NOT_DESTROYED = 'api.roles.not_destroyed'.freeze

      def perform
        object = CorevistAPI::Role.find_by_id(@form.id)

        return result.fail!(MSG_ROLE_NOT_FOUND) unless object

        object.destroy
        return result.fail!(MSG_ROLE_NOT_DESTROYED) unless object.destroyed?

        result(object)
      end
    end
  end
end
