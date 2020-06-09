module CorevistAPI
  module Policies::Admin
    class Roles::Permissions::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def index?
        user.authorized_for?('role_maintenance')
      end

      def create?
        index?
      end

      def destroy?
        index?
      end
    end
  end
end
