module CorevistAPI
  module Services::Partner
    class SearchService < CorevistAPI::Services::BaseServiceWithForm
      def perform
        rfc_result = rfc_service_for(:partner_search, @form, @params).call
        result(rfc_result.data[:partners])
      end
    end
  end
end