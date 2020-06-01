module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPConnections
    class UpdateService < CorevistAPI::Services::Base::UpdateService
      private

      def object_class
        CorevistAPI::SAPConnection
      end
    end
  end
end
