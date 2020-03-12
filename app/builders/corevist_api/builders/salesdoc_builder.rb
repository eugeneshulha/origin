module CorevistAPI
  module Builders
    class SalesdocBuilder < CorevistAPI::Builders::BaseBuilder

      def build
        yield(self)
        @object
      end

      def with_header

      end

      def with_items
        items.inject(@object.items) do |memo, _item|

          # TODO: move to a salesdoc item builder.
          item = CorevistAPI::Salesdoc::Item.new
          item.cond_uom = _item.cond_uom
          item.customer_material = _item.cust_mat
          item.description = _item.descr
          item.item_category = _item.item_cat
          item.item_number = _item.item_nr
          item.material = _item.mat
          item.net_price = _item.net_price
          item.net_value = _item.net_value
          item.no_change_reason = _item.no_chg_reason
          item.no_copy_reason = _item.no_copy_reason
          item.no_cwref_reason = _item.no_cwref_reason
          item.parent_item = _item.parent_item
          item.parent_item_use = _item.parent_item_use
          item.per = _item.per
          item.plant = _item.plant
          item.quantity = _item.qty
          item.rdd = _item.rdd
          item.ref_item_number = _item.ref_item_nr
          item.reference = _item.reference
          item.rejection_reason = _item.rej_reason
          item.sales_uom = _item.sales_uom
          item.ship_status = _item.ship_status
          memo << item
        end
      end

      def with_configs
        @object.config.partners = configs[0]&.partners&.split(',')
        @object.config.header_texts = configs[1]&.header_texts&.split(',')
        @object.config.item_texts = configs[2]&.item_texts&.split(',')
        @object.config.output_types = configs[3]&.output_types&.split(',')
        @object.config.price_rule = configs[4]&.price_rule
        @object.config.views = configs[5]&.views&.split(',')
      end

      def with_partners
      end

      def with_prices
        price_components.inject(@object.price_components) do |memo, _component|
          # TODO: move to a salesdoc price component builder.
          component = CorevistAPI::Salesdoc::PriceComponent.new
          component.item_number = _component.item_nr
          component.cond_type = _component.cond_type
          component.value = _component.value
          component.rate = _component.rate
          component.per = _component.per
          component.unit = _component.unit
          component.runit = _component.runit
          component.calc_type = _component.calct

          if _component.item_nr.to_i.zero?
            memo << component
          else
            item = @object.items.find { |x| x.item_number == component.item_number }
            item.price_components << component
          end

          memo
        end
      end

      def with_addresses
        with_postal_addresses
        with_street_addresses
      end

      def with_postal_addresses
      end

      def with_street_addresses
      end

      private

      def obtain_object
        doc = CorevistAPI::Salesdoc.new
        doc.doc_number = @params.with_indifferent_access[:doc_nr].first&.doc_nr
        raise CorevistAPI::ServiceException.new("api.salesdoc.doc_nr_not_found") unless doc.doc_number

        doc
      end
    end
  end
end
