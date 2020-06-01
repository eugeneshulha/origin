module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes
    class ShowService < CorevistAPI::Services::Base::ShowService
      private

      def object_class
        CorevistAPI::SAPDowntimes
      end
    end
  end
end
