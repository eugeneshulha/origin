module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes
    class DestroyService < CorevistAPI::Services::Base::DestroyService
      private

      def object_class
        CorevistAPI::SalesArea
      end
    end
  end
end
