module CorevistAPI
  module Policies
    class Payments::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def create?
        true
      end

      def new?
        true
      end
    end
  end
end
