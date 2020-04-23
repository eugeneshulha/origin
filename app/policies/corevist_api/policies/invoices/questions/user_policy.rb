module CorevistAPI
  module Policies
    class Invoices::Questions::UserPolicy < Admin::Users::UserPolicy
      def new?
        true
      end
    end
  end
end
