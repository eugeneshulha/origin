module CorevistAPI
  class Salesdoc
    class ItemData
      include CorevistAPI::FormatConversion

      attr_accessor :sold_to_description, :sold_to_number, :material, :output_types, :delivery_number, :item_number,
                    :quantity, :sales_uom, :ship_to_description, :ship_to_number, :to_date, :from_date, :reference


      format_date :to_date, :from_date
    end
  end
end
