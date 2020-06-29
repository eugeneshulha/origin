module CorevistAPI
  module Policies
    class Payments::Items::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def new?
        true
      end

      def download?
        true
      end
    end
  end
end
