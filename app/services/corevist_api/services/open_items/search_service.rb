module CorevistAPI
  module Services
    class OpenItems::SearchService< CorevistAPI::Services::BaseServiceWithForm
      def perform
        open_items = CorevistAPI::Context.current_user.payers&.inject([]) do |memo, payer|
          @form.payer_number = payer.number

          rfc_result = rfc_service_for(:open_items, @form, @params).call
          memo << rfc_result.data[:open_items]
          memo
        end

        result({ invoices: open_items.flatten.as_json })
      end
    end
  end
end
