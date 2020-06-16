module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes
    class DestroyService < CorevistAPI::Services::Base::DestroyService
      private

      def object_class
        CorevistAPI::SAPDowntime
      end
    end
  end
end
