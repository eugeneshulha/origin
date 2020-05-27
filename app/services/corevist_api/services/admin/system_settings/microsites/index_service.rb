module CorevistAPI
  module Services::Admin::SystemSettings::Microsites
    class IndexService < CorevistAPI::Services::Base::IndexService
      private

      def filter
        result(CorevistAPI::Microsite.all)
      end
    end
  end
end
