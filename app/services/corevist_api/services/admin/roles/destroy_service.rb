module CorevistAPI
  module Services
    class Admin::Roles::DestroyService < Base::DestroyService
      private

      def object_class
        CorevistAPI::Role
      end
    end
  end
end
