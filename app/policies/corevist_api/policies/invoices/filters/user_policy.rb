module CorevistAPI
  module Policies
    class Invoices::Filters::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def new?
        true
      end
    end
  end
end
