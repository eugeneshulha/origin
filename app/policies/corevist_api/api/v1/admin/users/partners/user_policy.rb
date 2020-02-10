module CorevistAPI
  module API::V1::Admin
    class Users::Partners::UserPolicy < ApplicationPolicy
      def index?
        true
      end

      def show?
        index?
      end

      def create?
        index?
      end
    end
  end
end
