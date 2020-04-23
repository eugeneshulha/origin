module CorevistAPI
  module Policies::Admin
    class Users::Partners::PartnerPolicy < CorevistAPI::Policies::ApplicationPolicy
      def index?
        true
      end

      def show?
        index?
      end

      def create?
        index?
      end
    end
  end
end
