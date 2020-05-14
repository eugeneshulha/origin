module CorevistAPI
  module Policies
    class Partners::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def index?
        true
      end
    end
  end
end
