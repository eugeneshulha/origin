module CorevistAPI
  module Policies
    class OpenItems::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def index?
        user.authorized_for?('open_items')
      end

      def index_configs?
        true
      end
    end
  end
end
