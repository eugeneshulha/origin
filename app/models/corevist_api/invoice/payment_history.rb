module CorevistAPI
  class Invoice
    class PaymentHistory
      include CorevistAPI::FormatConversion

      attr_accessor :date, :amount, :text

      format_amount :amount
      format_date :date
    end
  end
end
