module CorevistAPI
  module Policies
    class Invoices::UserPolicy < CorevistAPI::Policies::ApplicationPolicy
      def index?
        true
      end

      def index_configs?
        true
      end

      def new?
        self.user.roles.includes(:permissions).find_by(permissions: { title: 'view_invoices'}).present?
      end

      def show?
        self.user.roles.includes(:permissions).find_by(permissions: { title: 'view_invoices'}).present?
      end
    end
  end
end
