module CorevistAPI
  module Services::Admin::SystemSettings::Microsites
    class UpdateService < CorevistAPI::Services::Base::UpdateService
      private

      def object_class
        CorevistAPI::Microsite
      end

      def depended_class
        CorevistAPI::SalesArea
      end

      def depended_key
        :sales_area_ids
      end
    end
  end
end
