module CorevistAPI
  module Policies
    class Dashboards::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def new?
        true
      end

      def navigation?
        true
      end
    end
  end
end
