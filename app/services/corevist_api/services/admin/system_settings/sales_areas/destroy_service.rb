module CorevistAPI
  module Services::Admin::SystemSettings::SalesAreas
    class DestroyService < CorevistAPI::Services::Base::DestroyService
      private

      def object_class
        CorevistAPI::SalesArea
      end
    end
  end
end
