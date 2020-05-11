module CorevistAPI
  module Policies::Admin
    class Roles::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def create?
        user.authorized_for?('role_maintenance')
      end

      def show?
        create?
      end

      def update?
        create?
      end

      def destroy?
        create?
      end
    end
  end
end
