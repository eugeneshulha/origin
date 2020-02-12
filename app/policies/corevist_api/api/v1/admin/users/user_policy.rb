module CorevistAPI
  module API::V1::Admin
    class Users::UserPolicy < ApplicationPolicy
      def show?
        user.system_admin?
      end
    end
  end
end
