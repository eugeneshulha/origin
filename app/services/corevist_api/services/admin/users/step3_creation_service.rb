module CorevistAPI
  module Services
    class Admin::Users::Step3CreationService< CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        raise CorevistAPI::ServiceException.new(not_found_msg) unless user

        assignable_roles = @form.assignable_role_ids.each_with_object([]) do |assignable_role_id, memo|
          assignable_role = CorevistAPI::AssignableRole.find_by_id(assignable_role_id)
          raise CorevistAPI::ServiceException.new("api.#{namespace}.assignable_role.not_found") unless assignable_role

          memo << assignable_role
        end
        user.assignable_roles = assignable_roles

        result(user)
      end
    end
  end
end
