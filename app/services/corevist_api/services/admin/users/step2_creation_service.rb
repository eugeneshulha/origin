module CorevistAPI
  module Services
    class Admin::Users::Step2CreationService< CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        raise CorevistAPI::ServiceException.new(not_found_msg) unless user

        roles = @form.role_ids.each_with_object([]) do |role_id, memo|
          role = CorevistAPI::Role.find_by_id(role_id)
          raise CorevistAPI::ServiceException.new("api.#{namespace}.roles.not_found") unless role

          memo << role
        end
        user.roles = roles
        user.reload
        
        result(user)
      end
    end
  end
end
