module CorevistAPI
  module Policies
    class Payments::OutputTypes::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def index?
        true
      end

      def show?
        index?
      end
    end
  end
end
