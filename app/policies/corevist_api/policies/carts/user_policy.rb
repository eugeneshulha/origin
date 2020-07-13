module CorevistAPI
  module Policies::Carts
    class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def get_last_active?
        true
      end
    end
  end
end
