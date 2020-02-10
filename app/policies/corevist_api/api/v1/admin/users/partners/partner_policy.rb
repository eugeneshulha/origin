module CorevistAPI
  module API::V1
    class Admin::Users::Partners::PartnerPolicy < ApplicationPolicy
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
