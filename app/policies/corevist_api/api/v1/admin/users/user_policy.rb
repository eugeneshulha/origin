module CorevistAPI
  module API::V1::Admin
    class Users::UserPolicy < ApplicationPolicy
      def create?
        user.system_admin?
      end

      def show?
        user.system_admin?
      end
    end
  end
end
