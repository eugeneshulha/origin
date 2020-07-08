module CorevistAPI
  module Policies::Admin
    class Users::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def create?
        user.authorized_for?('user_maintenance')
      end

      def show?
        !(CorevistAPI::Context.current_user == @user)
      end

      def destroy?
        create?
      end

      def update?
        create?
      end

      def download?
        create?
      end
    end
  end
end
