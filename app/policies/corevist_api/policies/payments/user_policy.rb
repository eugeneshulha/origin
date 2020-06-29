module CorevistAPI
  module Policies
    class Payments::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def index?
        user.authorized_for?('search_for_payments')
      end

      def index_configs?
        index?
      end

      def new?
        user.authorized_for?('view_payments')
      end

      def show?
        new?
      end

      def download?
        new?
      end
    end
  end
end
