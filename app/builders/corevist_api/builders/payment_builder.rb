module CorevistAPI
  module Builders
    class PaymentBuilder < CorevistAPI::Builders::BaseBuilder
      MAPPING = {
          amnt: :amount,
          amntdc: :amount_in_doc_currency,
          ass_nr: :assignment_number,
          cc_number: :cc_number,
          cc_type: :cc_type,
          curr: :currency,
          db_cr_ind: :debit_or_credit,
          description: :description,
          doc_curr: :doc_currency,
          fi_dtype: :fiscal_type,
          item_text: :item_text,
          pay_doc_fisc_year: :fiscal_year,
          pay_doc_no: :payment_number,
          payment_date: :payment_date,
          rc: :reason_code,
      }.with_indifferent_access

      ITEMS_MAPPING = {
          amnt: :amount,
          amntdc: :amount_in_doc_currency,
          ass_nr: :assignment_number,
          curr: :currency,
          db_cr_ind: :debit_or_credit,
          description: :description,
          doc_curr: :document_currency,
          fi_dtype: :fiscal_type,
          inv_amntdc: :invoice_amount,
          inv_doc_fisc_year: :invoice_fiscal_year,
          inv_doc_no: :invoice_number,
          inv_obj_type: :obj_type,
          item_text: :item_text,
          pay_doc_fisc_year: :payment_fiscal_year,
          pay_doc_no: :payment_number,
          pstng_date: :posting_date,
      }.with_indifferent_access

      def build
        yield(self)
        @object
      end

      def with_base_params
        MAPPING.each { |k,v| @object.send("#{v}=", @params[:payment].send(k)) }
      end

      def with_items
        return unless @object.payment_number
        items_data = @params[:items]&.select {|item| item.pay_doc_no == @object.payment_number }

        item = CorevistAPI::Payment::Item.new

        items_data.inject(@object.items) do |memo, data|
          ITEMS_MAPPING.each { |k,v| item.send("#{v}=", data.send(k)) }
          memo << item
        end
      end

      private

      def obtain_object
        CorevistAPI::Payment.new
      end
    end
  end
end
