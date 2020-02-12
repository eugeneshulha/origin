module CorevistAPI
  module API::V1::Admin
    class Users::UserPolicy < ApplicationPolicy
      def create?
        true
      end
    end
  end
end
