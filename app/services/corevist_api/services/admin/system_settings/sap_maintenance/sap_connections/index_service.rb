module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPConnections
    class IndexService < CorevistAPI::Services::Base::IndexService
      private

      def filter
        result(CorevistAPI::SAPConnection.all)
      end
    end
  end
end
