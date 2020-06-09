module CorevistAPI
  module Policies
    class Invoices::Items::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def new?
        true
      end

      def download?
        true
      end
    end
  end
end
