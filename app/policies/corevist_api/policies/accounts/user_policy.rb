module CorevistAPI
  module Policies
    class Accounts::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def show?
        true
      end

      class Scope
        attr_reader :user, :scope

        def initialize(user, scope)
          @user = user
          @scope = scope
        end

        def resolve
          scope
        end
      end
    end
  end
end
