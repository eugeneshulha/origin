require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/payment/item.rb')

module CorevistAPI
  class Payment
    include CorevistAPI::FormatConversion

    attr_accessor :amount, :amount_in_doc_currency, :assignment_number, :cc_number, :cc_type, :currency,
                  :debit_or_credit, :description, :doc_currency, :fiscal_type, :item_text, :fiscal_year,
                  :payment_number, :payment_date, :reason_code
    # arrays
    attr_accessor :items

    format_date :payment_date
    format_amount :amount, :amount_in_doc_currency

    def initialize
      @items = []
    end

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
