module CorevistAPI
  module Policies
    class Payments::Questions::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def new?
        true
      end
    end
  end
end
