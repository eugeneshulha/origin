module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes
    class UpdateService < CorevistAPI::Services::Base::UpdateService
      private

      def object_class
        CorevistAPI::SAPDowntimes
      end
    end
  end
end
