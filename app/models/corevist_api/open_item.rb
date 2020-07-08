module CorevistAPI
  class OpenItem
    include CorevistAPI::FormatConversion
    
    attr_accessor :invoice_number, :posting_date, :due_date, :amount, :amount_in_doc_currency, :currency, :doc_currency,
        :fi_number, :fi_doc_type, :year, :obj_type, :debit_or_credit, :reason_code, :text, :assignment_number,
        :partially_paid, :payable, :selected, :payment_amount, :due_today, :payment_terms, :payment_t_text,
        :item_number, :reference, :paid_amount, :description, :linkable_invoice, :error_message, :po_number

    attr_accessor :debit

    format_date :posting_date, :due_date
    format_number :amount, :amount_in_doc_currency, :due_today, :paid_amount

    def initialize
      @debit = true
    end
  end
end
