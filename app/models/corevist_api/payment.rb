require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/payment/item.rb')

module CorevistAPI
  class Payment
    attr_accessor :amount, :amount_in_doc_currency, :assignment_number, :cc_number, :cc_type, :currency,
                  :debit_or_credit, :description, :doc_currency, :fiscal_type, :item_text, :fiscal_year,
                  :payment_number, :payment_date, :reason_code
    # arrays
    attr_accessor :items

    def initialize
      @items = []
    end

    def as_json
      super.except("items").merge({ invoices: items.map(&:invoice_number) })
    end
  end
end
