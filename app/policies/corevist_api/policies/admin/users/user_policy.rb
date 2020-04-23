module CorevistAPI
  module Policies::Admin
    class Users::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def create?
        true
      end

      def show?
        create?
      end

      def destroy?
        create?
      end

      def update?
        create?
      end
    end
  end
end
