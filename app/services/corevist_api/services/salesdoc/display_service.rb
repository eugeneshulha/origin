module CorevistAPI
  module Services::Salesdoc
    class DisplayService < CorevistAPI::Services::BaseService

      def call
        perform!
      end

      private

      def perform!
        @rfc_result = rfc_service_for(:salesdoc_display, @form, @params).call
        result(@rfc_result)
      end
    end
  end
end
