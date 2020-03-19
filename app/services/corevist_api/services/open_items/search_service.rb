module CorevistAPI
  module Services
    class OpenItems::SearchService < BaseServiceWithForm
      def perform
        rfc_result = rfc_service_for(:open_items, @form, @params).call
        result({ invoices: rfc_result.data[:open_items].as_json })
      end
    end
  end
end
