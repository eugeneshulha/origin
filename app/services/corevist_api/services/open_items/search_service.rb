module CorevistAPI
  module Services
    class OpenItems::SearchService< CorevistAPI::Services::BaseServiceWithForm
      include Paginatable

      private

      def perform
        rfc_result = rfc_service_for(:open_items, @form, @params).call
        open_items = paginate(invoices: rfc_result.data[:open_items].flatten)

        result(open_items)
      end
    end
  end
end
