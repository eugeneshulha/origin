module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes
    class IndexService < CorevistAPI::Services::Base::IndexService
      private

      def filter
        result(CorevistAPI::SAPDowntime.all)
      end
    end
  end
end
