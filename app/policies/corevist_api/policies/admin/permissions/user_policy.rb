module CorevistAPI
  module Policies::Admin::Permissions
    class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def index?
        user.authorized_for?('role_maintenance')
      end
    end
  end
end
