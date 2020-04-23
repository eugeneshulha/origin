module CorevistAPI
  module Policies
    class Invoices::Questions::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def new?
        true
      end
    end
  end
end
