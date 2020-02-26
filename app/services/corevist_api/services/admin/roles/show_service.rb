module CorevistAPI
  module Services
    class Admin::Roles::ShowService < BaseServiceWithForm
      MSG_ROLE_NOT_FOUND = 'api.roles.not_found'.freeze

      def perform
        object = CorevistAPI::Role.find_by_id(@form.id)

        return result.fail!(MSG_ROLE_NOT_FOUND) unless object

        result(object)
      end
    end
  end
end
