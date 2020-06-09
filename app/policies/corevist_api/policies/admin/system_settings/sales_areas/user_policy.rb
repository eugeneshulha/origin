module CorevistAPI
  module Policies::Admin::SystemSettings::SalesAreas
    class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def index?
        user.authorized_for?('system_maintenance')
      end

      def create?
        index?
      end

      def update?
        index?
      end

      def destroy?
        index?
      end
    end
  end
end
