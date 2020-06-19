module CorevistAPI
  module Policies
    class Salesdocs::OutputTypes::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def index?
        true
      end

      def show?
        index?
      end
    end
  end
end
