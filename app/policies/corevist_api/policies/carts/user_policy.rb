module CorevistAPI
  module Policies::Carts
    class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def simulate?
        true
      end

      def create?
        true
      end
    end
  end
end
