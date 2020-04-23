module CorevistAPI
  module Policies::Admin
    class Users::Partners::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
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
