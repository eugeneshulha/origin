module CorevistAPI
  module Policies
    class Salesdocs::Filters::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def new?
        true
      end
    end
  end
end
