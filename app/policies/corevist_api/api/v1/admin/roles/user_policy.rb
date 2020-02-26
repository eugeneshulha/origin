module CorevistAPI
  module API::V1::Admin
    class Roles::UserPolicy < ApplicationPolicy
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
