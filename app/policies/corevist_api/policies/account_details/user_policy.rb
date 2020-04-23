module CorevistAPI
  module Policies
    class AccountDetails::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def show?
        true
      end
    end
  end
end
