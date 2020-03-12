module CorevistAPI
  module API::V1::Admin
    class Users::UserPolicy < ApplicationPolicy
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
