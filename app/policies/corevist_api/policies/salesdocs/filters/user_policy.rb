module CorevistAPI
  module Policies
    class Salesdocs::Filters::UserPolicy < Admin::Users::UserPolicy
      def new?
        true
      end
    end
  end
end
