module CorevistAPI
  module Policies
    class Salesdocs::Questions::UserPolicy < Admin::Users::UserPolicy
      def new?
        true
      end
    end
  end
end
