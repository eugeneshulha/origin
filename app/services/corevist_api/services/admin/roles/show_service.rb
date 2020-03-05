module CorevistAPI
  module Services
    class Admin::Roles::ShowService < Base::ShowService
      private

      def object_class
        CorevistAPI::Role
      end
    end
  end
end
