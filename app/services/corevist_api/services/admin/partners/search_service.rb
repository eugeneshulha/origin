module CorevistAPI
  module Services::Admin::Partners
    class SearchService < CorevistAPI::Services::BaseServiceWithForm
      def perform
        rfc_result = rfc_service_for(:search_partner).call
        result(rfc_result.data[:partners])
      end
    end
  end
end
