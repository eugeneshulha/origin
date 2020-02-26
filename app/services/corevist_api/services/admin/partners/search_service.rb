module CorevistAPI
  module Services
    class Admin::Partners::SearchService < BaseServiceWithForm
      def perform
        rfc_result = rfc_service_for(:partner_search, @form, @params).call
        result(rfc_result.data[:partners])
      end
    end
  end
end
