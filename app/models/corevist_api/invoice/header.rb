module CorevistAPI
  class Invoice::Header

      # BILL_DATE|TAX|STATUS|DUE_DATE|COMP_CODE|SALES_ORDER|
      #
      attr_accessor :billing_date, :tax,
                    :status, :due_date, :company_code, :total_value, :price_components,
                    :sales_order
  end
end
