module CorevistAPI
  module Services::Admin::SystemSettings::SalesAreas
    class CreateService < CorevistAPI::Services::Base::CreateService
      private

      def object_class
        CorevistAPI::SalesArea
      end
    end
  end
end
