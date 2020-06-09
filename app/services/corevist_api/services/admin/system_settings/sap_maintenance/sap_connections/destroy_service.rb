module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPConnections
    class DestroyService < CorevistAPI::Services::Base::DestroyService
      private

      def object_class
        CorevistAPI::SAPConnection
      end
    end
  end
end
