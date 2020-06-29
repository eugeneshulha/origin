module CorevistAPI
  class Payment
    class Item
      attr_accessor :amount, :amount_in_doc_currency, :assignment_number, :currency, :debit_or_credit, :description,
                    :document_currency, :fiscal_type, :invoice_amount, :invoice_fiscal_year, :invoice_number, :obj_type,
                    :item_text, :payment_fiscal_year, :payment_number, :posting_date
    end
  end
end
