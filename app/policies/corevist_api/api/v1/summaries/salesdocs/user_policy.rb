module CorevistAPI
  module API::V1
    class Summaries::Salesdocs::UserPolicy < Admin::Users::UserPolicy
      def index?
        true
      end
    end
  end
end
