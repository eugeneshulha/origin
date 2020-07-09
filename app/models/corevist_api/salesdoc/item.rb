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
      format_number :net_price, :net_value
      sort_as_numeric :net_price, :net_value

      def as_json
        {
            cond_uom: self.cond_uom,
            customer_material: self.customer_material,
            description: self.description,
            item_category: self.item_category,
            item_number: self.item_number,
            material: self.material,
            net_price: self.net_price,
            net_value: self.net_value,
            no_change_reason: self.no_change_reason,
            no_copy_reason: self.no_copy_reason,
            no_cwref_reason: self.no_cwref_reason,
            parent_item: self.parent_item,
            parent_item_use: self.parent_item_use,
            per: self.per,
            plant: self.plant,
            quantity: self.quantity,
            rdd: self.rdd,
            ref_item_number: self.ref_item_number,
            reference: self.reference,
            rejection_reason: self.rejection_reason,
            sales_uom: self.sales_uom,
        }
      end
    end
  end
end
