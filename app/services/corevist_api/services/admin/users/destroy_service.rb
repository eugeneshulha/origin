module CorevistAPI
  module Services
    class Admin::Users::DestroyService < Base::DestroyService
      private

      def object_class
        CorevistAPI::User
      end
    end
  end
end
