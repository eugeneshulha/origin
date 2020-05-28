module CorevistAPI
  module Services::Admin::SystemSettings::SalesAreas
    class ShowService < CorevistAPI::Services::Base::ShowService
      private

      def object_class
        CorevistAPI::SalesArea
      end
    end
  end
end
