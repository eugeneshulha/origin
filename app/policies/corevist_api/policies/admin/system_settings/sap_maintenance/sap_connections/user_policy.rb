module CorevistAPI
  module Policies::Admin::SystemSettings::SAPMaintenance::SAPConnections
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

      def ping?
        index?
      end
    end
  end
end
