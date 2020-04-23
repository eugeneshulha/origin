module CorevistAPI
  module Policies::Admin
    class Roles::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def create?
        true
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
