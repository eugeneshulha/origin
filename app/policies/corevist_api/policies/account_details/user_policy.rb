module CorevistAPI
  module Policies
    class AccountDetails::UserPolicy < Admin::Users::UserPolicy
      def show?
        true
      end
    end
  end
end
