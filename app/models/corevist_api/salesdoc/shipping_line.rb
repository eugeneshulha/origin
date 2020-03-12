module CorevistAPI
  class Salesdoc
    class ShippingLine
      attr_accessor :item_number, :delivery_date, :quantity, :batch, :delivery_number, :delivery_item_number,
                    :ship_status, :invoice_number, :proforma_invoice_number, :sales_uom, :tracking_numbers,
                    # associations
                    :delivery
    end
  end
end
