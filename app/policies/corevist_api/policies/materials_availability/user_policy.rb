module CorevistAPI
  module Policies::MaterialsAvailability
    class UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def index?
        true
      end
    end
  end
end
