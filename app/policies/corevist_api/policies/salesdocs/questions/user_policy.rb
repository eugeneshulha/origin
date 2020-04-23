module CorevistAPI
  module Policies
    class Salesdocs::Questions::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def new?
        true
      end
    end
  end
end
