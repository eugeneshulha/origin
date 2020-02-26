module CorevistAPI
  module Services
    class OpenItems::SearchService < BaseServiceWithForm
      def perform
        rfc_result = rfc_service_for(:open_items).call
        result(rfc_result.data[:open_items])
      end
    end
  end
end
