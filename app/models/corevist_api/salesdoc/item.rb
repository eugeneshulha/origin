module CorevistAPI
  class Salesdoc
    class Item
      include CorevistAPI::FormatConversion
      include CorevistAPI::Sortable

      attr_accessor :customer_material,
                    :no_copy_reason, :ref_item_number,
                    :rdd, :rejection_reason, :plant, :ship_status, :reference, :no_change_reason, :no_cwref_reason,
                    # associations
                    :shipping_lines, :characteristics, :parent_item_use

      format_date :rdd
      sort_as_date :rdd
    end
  end
end
