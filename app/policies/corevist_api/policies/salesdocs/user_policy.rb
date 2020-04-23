module CorevistAPI
  module Policies
    class Salesdocs::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def index?
        true
      end

      def index_configs?
        true
      end

      def new?
        true
      end

      def show?
        true
      end
    end
  end
end
