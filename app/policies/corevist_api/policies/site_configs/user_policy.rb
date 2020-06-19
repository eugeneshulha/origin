module CorevistAPI
  module Policies
    class SiteConfigs::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def show?
        true
      end
    end
  end
end
