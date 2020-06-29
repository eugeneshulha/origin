module CorevistAPI
  module Policies::OpenItems
    class PaymentMethods::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def new?
        true
      end
    end
  end
end
