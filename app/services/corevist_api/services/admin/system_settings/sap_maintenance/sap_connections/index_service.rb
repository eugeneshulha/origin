module CorevistAPI
  module Services::Admin::SystemSettings::SAPMaintenance::SAPConnections
    class IndexService < CorevistAPI::Services::Base::IndexService
      def perform
        items = sort_by_param(filter_by_query(CorevistAPI::SAPConnection.all))

        result(paginate(items: items))
      end
    end
  end
end
