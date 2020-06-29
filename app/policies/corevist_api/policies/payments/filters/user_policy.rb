module CorevistAPI
  module Policies
    class Payments::Filters::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def new?
        true
      end
    end
  end
end
