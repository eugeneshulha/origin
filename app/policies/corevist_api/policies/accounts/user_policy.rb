module CorevistAPI
  module Policies
    class Accounts::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def show?
        true
      end
    end
  end
end
