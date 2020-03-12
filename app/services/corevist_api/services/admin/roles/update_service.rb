module CorevistAPI
  module Services
    class Admin::Roles::UpdateService < Base::UpdateService
      private

      def object_class
        CorevistAPI::Role
      end
    end
  end
end
