module CorevistAPI
  module API::V1::Admin
    class Users::PartnersController < BaseController
      # include CorevistAPI::UserSpecific
      form_performer_for :destroy

      def index
        @collection = policy_scope(@user.partners, policy_scope_class: policy_class(CorevistAPI::Partner, true))
      end
    end
  end
end
