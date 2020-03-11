module CorevistAPI
  module Services::Invoice
    class SortItemsService < CorevistAPI::Services::BaseService

      def call
        perform!
      end

      private

      def perform!
        @rfc_result = rfc_service_for(@object.api_names[:display], @object, @params).call
        result(@rfc_result.data['items']&.as_json)
      end
    end
  end
end
