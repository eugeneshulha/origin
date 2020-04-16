module CorevistAPI
  module Services::Invoice
    class Pay < CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        rfc_result = rfc_service_for(:open_items, @form, @params).call

        items = rfc_result.data[:open_items].select do |item|
          @form.invoices.to_a.include?(item.inv)
        end

        raise CorevistAPI::ServiceException.new('open_items.items_to_pay_not_found') if items.blank?

        @form.invoices = items
        @form.currency = rfc_result.data[:accounting_data].pay_curr
        @form.amount = (items.sum { |x| x.due_today.to_f } * 100).to_i

        spreedly = CorevistAPI::PaymentProcessors::SpreedlyAPI.instance

        if @form.pay_with_cc?
          spreedly.authorize_amount(@form)
        end

        @rfc_result = rfc_service_for(:pay_invoices, @form, @params).call

        if @rfc_result.data[:payment_doc_number]
          spreedly.capture_amount(@form.auth_token)
          Mailer.pay_invoices_confirmation(CorevistAPI::Context.current_user.uuid, @rfc_result.data[:payment_doc_number]).deliver_later
        else
          raise ServiceException.new('Something is wrong with your payment')
        end

        result(@rfc_result.data)
      end
    end
  end
end
