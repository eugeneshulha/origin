module CorevistAPI
  class Payment
    class Item
      include CorevistAPI::FormatConversion

      attr_accessor :amount, :amount_in_doc_currency, :assignment_number, :currency, :debit_or_credit, :description,
                    :document_currency, :fiscal_type, :invoice_amount, :invoice_fiscal_year, :invoice_number, :obj_type,
                    :item_text, :payment_fiscal_year, :payment_number, :posting_date

      format_amount :amount, :amount_in_doc_currency
      format_date :posting_date

      def as_json(options = nil)
        hash = instance_variables.inject({}) do |memo, var|
          v = var.to_s.tr("@", '')
          memo[v] = self.send(v)
          memo
        end

        hash
      end
    end
  end
end
