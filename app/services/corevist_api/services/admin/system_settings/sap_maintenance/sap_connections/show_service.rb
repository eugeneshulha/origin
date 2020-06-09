module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPConnections
    class ShowService < CorevistAPI::Services::Base::ShowService
      private

      def object_class
        CorevistAPI::SAPConnection
      end
    end
  end
end
