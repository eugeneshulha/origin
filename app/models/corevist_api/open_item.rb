module CorevistAPI
  class OpenItem
    include CorevistAPI::FormatConversion
    include CorevistAPI::Sortable

    attr_accessor :invoice_number, :posting_date, :due_date, :amount, :amount_in_doc_currency, :currency, :doc_currency,
        :fi_number, :fi_doc_type, :year, :obj_type, :debit_or_credit, :reason_code, :text, :assignment_number,
        :partially_paid, :payable, :selected, :payment_amount, :due_today, :payment_terms, :payment_t_text,
        :item_number, :reference, :paid_amount, :description, :linkable_invoice, :error_message, :po_number

    attr_accessor :debit

    format_date :posting_date, :due_date
    sort_as_date :posting_date, :due_date
    format_number :amount, :amount_in_doc_currency, :due_today, :paid_amount

    def initialize
      @debit = true
    end

    def as_json
      {
        invoice_number: self.invoice_number,
        posting_date: self.posting_date,
        due_date: self.due_date,
        amount: self.amount,
        amount_in_doc_currency: self.amount_in_doc_currency,
        currency: self.currency,
        doc_currency: self.doc_currency,
        description: self.description,
        obj_type: self.obj_type,
        text: self.text,
        reason_code: self.reason_code,
        assignment_number: self.assignment_number,
        item_number: self.item_number,
        partially_paid: self.partially_paid,
        fi_number: self.fi_number,
        year: self.year,
        payment_t_text: self.payment_t_text,
        due_today: self.due_today,
        payment_terms: self.payment_terms,
        reference: self.reference,
        po_number: self.po_number,
        fi_doc_type: self.fi_doc_type,
        paid_amount: self.paid_amount,
      }
    end
  end
end
