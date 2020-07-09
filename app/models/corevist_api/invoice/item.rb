module CorevistAPI
  class Invoice
    class Item
      include CorevistAPI::FormatConversion
      attr_accessor :sales_order, :po_number

      format_amount :net_value, :net_price
      format_date :rdd
    end
  end
end
