module CorevistAPI
  module Policies::Carts::Items
    class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def create?
        true
      end

      def update?
        create?
      end
    end
  end
end
