module CorevistAPI
  class Salesdoc
    class ShippingLine
      include CorevistAPI::FormatConversion
      include CorevistAPI::Sortable

      attr_accessor :item_number, :delivery_date, :quantity, :batch, :delivery_number, :delivery_item_number,
                    :ship_status, :invoice_number, :proforma_invoice_number, :sales_uom, :tracking_numbers,
                    # associations
                    :delivery

      format_date :delivery_date
      sort_as_date :delivery_date
    end
  end
end
