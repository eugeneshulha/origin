module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes
    class IndexService < CorevistAPI::Services::Base::IndexService
      def perform
        items = sort_by_param(filter_by_query(CorevistAPI::SAPDowntime.all))

        result(paginate(items: items))
      end
    end
  end
end
