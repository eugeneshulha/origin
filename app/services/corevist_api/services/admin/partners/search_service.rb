module CorevistAPI
  module Services::Admin::Partners
    class SearchService < CorevistAPI::Services::BaseServiceWithForm
      def perform
        rfc_result = rfc_service_for(:search_partner).call
        result(rfc_result.data[:partners])
      end

      def invalid_object_error
        result.fail!(@form.errors.full_messages)
      end
    end
  end
end
