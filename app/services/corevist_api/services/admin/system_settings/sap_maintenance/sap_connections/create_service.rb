module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPConnections
    class CreateService < CorevistAPI::Services::Base::CreateService
      private

      def object_class
        CorevistAPI::SAPConnection
      end
    end
  end
end
