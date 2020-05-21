module CorevistAPI
  module Policies
    class Invoices::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def index?
        user.authorized_for?('search_for_invoices')
      end

      def index_configs?
        true
      end

      def new?
        user.authorized_for?('view_invoices')
      end

      def show?
        user.authorized_for?('view_invoices')
      end

      def download?
        user.authorized_for?('download_invoices')
      end
    end
  end
end
