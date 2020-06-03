module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes
    class CreateService < CorevistAPI::Services::Base::CreateService
      private

      def object_class
        CorevistAPI::SAPDowntime
      end
    end
  end
end
