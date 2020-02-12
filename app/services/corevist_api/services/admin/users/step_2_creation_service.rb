module CorevistAPI
  module Services
    class Admin::Users::Step2CreationService < BaseServiceWithForm
      def perform
        return result.fail!('api.errors.user_not_found') unless user

        @form.role_ids.each do |role_id|
          role = CorevistAPI::Role.find_by_id(role_id)
          return result.fail!('api.errors.role_not_found') unless role

          user.roles << role
        end

        return result.fail!(user.errors.full_messages) unless user.save

        result(user)
      end
    end
  end
end
