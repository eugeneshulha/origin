module CorevistAPI
  module API::V1::Admin
    class Users::UserPolicy < ApplicationPolicy
      def create?
        true
      end

      def show?
        create?
      end
    end
  end
end
