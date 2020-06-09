module CorevistAPI
  module Policies
    class Salesdocs::Items::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def new?
        true
      end

      def download?
        true
      end
    end
  end
end
