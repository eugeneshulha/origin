module CorevistAPI
  class Salesdoc::Item
    # salesdoc
    attr_accessor :customer_material,
                  :no_copy_reason, :ref_item_number,
                  :rdd, :rejection_reason, :plant, :ship_status, :reference, :no_change_reason, :no_cwref_reason,
                  # associations
                  :shipping_lines, :characteristics, :parent_item_use
  end
end
