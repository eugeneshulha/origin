module CorevistAPI
  module Policies
    class Invoices::Filters::UserPolicy < Admin::Users::UserPolicy
      def new?
        true
      end
    end
  end
end
