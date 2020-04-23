module CorevistAPI
  module Policies
    class Accounts::UserPolicy < Admin::Users::UserPolicy
      def show?
        true
      end
    end
  end
end
