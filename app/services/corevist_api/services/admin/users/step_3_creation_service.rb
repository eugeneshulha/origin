module CorevistAPI
  module Services
    class Admin::Users::Step3CreationService < BaseServiceWithForm
      def perform
        return result.fail!('api.errors.user_not_found') unless user

        @form.assignable_role_ids.each do |assignable_role_id|
          assignable_role = CorevistAPI::AssignableRole.find_by_id(assignable_role_id)
          return result.fail!('api.errors.assignable_role_not_found') unless assignable_role

          user.assignable_roles << assignable_role
        end

        return result.fail!(user.errors.full_messages) unless user.save

        result(user)
      end
    end
  end
end
