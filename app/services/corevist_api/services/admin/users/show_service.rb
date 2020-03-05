module CorevistAPI
  module Services
    class Admin::Users::ShowService < Base::ShowService
      private

      def object_class
        CorevistAPI::User
      end
    end
  end
end
