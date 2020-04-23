module CorevistAPI
  module Policies
    class OpenItems::UserPolicy < CorevistAPI::Policies::Admin::Users::UserPolicy
      def index?
        true
      end

      def index_configs?
        true
      end
    end
  end
end
