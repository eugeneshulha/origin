module CorevistAPI
  module API::V1::Admin
    class Users::PartnersController < BaseController
      include CorevistAPI::UserSpecific

      def index
        @collection = policy_scope(@user.partners, policy_scope_class: policy_class(CorevistAPI::Partner, true))
      end

      def create
        perform_action(action_name)
      end
    end
  end
end
