module CorevistAPI
  module Document::Item
    extend ActiveSupport::Concern
    include CorevistAPI::FormatConversion
    include CorevistAPI::Sortable

    included do
      attr_accessor :item_number, :material, :quantity, :sales_uom, :description, :item_category, :net_value, :net_price,
                    :per, :cond_uom, :parent_item, :currency,

                    # arrays to parse
                    :price_components, :texts

      format_amount :net_price, :net_value
      sort_as_number :quantity, :per

      def initialize
        @price_components = []
      end
    end
  end
end
