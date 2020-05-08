module CorevistAPI
  module Document::Item
    extend ActiveSupport::Concern
    include CorevistAPI::FormatConversion
    include CorevistAPI::Sortable

    included do
      attr_accessor :item_number, :material, :quantity, :sales_uom, :description, :item_category, :net_value, :net_price,
                    :per, :cond_uom, :parent_item,

                    # arrays to parse
                    :price_components, :texts

      format_number :net_price, :net_value
      sort_as_numeric :quantity, :net_value, :net_price, :per

      def initialize
        @price_components = []
      end
    end
  end
end
