module CorevistAPI
  module API::V1
    class AccountDetails::UserPolicy < Admin::Users::UserPolicy
      def show?
        true
      end
    end
  end
end
