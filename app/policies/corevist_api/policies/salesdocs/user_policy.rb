module CorevistAPI
  module Policies
    class Salesdocs::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def index?
        user.authorized_for?('search_for_orders')
      end

      def index_configs?
        true
      end

      def new?
        true
      end

      def show?
        user.authorized_for?('view_orders')
      end
    end
  end
end
