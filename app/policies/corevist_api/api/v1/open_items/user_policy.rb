module CorevistAPI
  module API::V1
    class OpenItems::UserPolicy < Admin::Users::UserPolicy
      def index?
        true
      end
    end
  end
end
