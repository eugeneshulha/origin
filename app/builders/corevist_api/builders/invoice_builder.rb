module CorevistAPI
  module Builders
    class InvoiceBuilder < CorevistAPI::Builders::BaseBuilder
      MAX_ADDRESSES_COUNT = 3
      MAPPING = {
          bil_date: :billing_date,
          tax: :tax,
          status: :status,
          due_date: :due_date,
          comp_code: :company_code,
          doc_nr: :doc_number,
          doc_type: :doc_type,
          doc_cat: :doc_category,
          sa: :sales_area,
          po_number: :po_number,
          curr: :currency,
          net_value: :net_value,
          payment_terms: :payment_terms,
          paymt_t_text: :payment_terms_text,
          sales_order: :sales_order
      }.with_indifferent_access

      def build
        yield(self)
        @object
      end

      def with_header
        header.instance_variables.each do |h|
          v = h.to_s.tr('@', '')
          next unless MAPPING[v]

          @object.header.send("#{MAPPING[v]}=", h.instance_variable_get("@#{v}"))
        end
      end

      def with_items
        items.inject(@object.items) do |memo, _item|
          # TODO: move to a salesdoc item builder.
          item = CorevistAPI::Invoice::Item.new
          item.cond_uom = _item.cond_uom
          item.description = _item.descr
          item.item_category = _item.item_cat
          item.item_number = _item.item_nr
          item.material = _item.mat
          item.net_price = _item.net_price
          item.net_value = _item.net_value
          item.parent_item = _item.parent_item
          item.per = _item.per
          item.quantity = _item.qty
          item.sales_order = _item.sales_order
          item.sales_uom = _item.sales_uom
          memo << item
        end
      end

      def with_configs
        @object.config.partners = configs.partners&.split(',')
        @object.config.header_texts = configs.header_texts&.split(',')
        @object.config.item_texts = configs.item_texts&.split(',')
        @object.config.output_types = configs.output_types&.split(',')
        @object.config.price_rule = configs.price_rule
        @object.config.views = configs.views&.split(',')
      end

      def with_partners
        sales_area = CorevistAPI::SalesArea.find_by(title: @params[:header].sa)
        raise ServiceException('sales area of partner not found') unless sales_area

        partners.each do |partner|
          partner_params = {
              rfc_partner: Struct.new(:nr).new(partner.nr),
              sales_area: sales_area,
              user: CorevistAPI::Context.current_user,
              function: partner.fct,
              postal_addresses: postal_addresses.select { |x| x.nr == partner.addr_nr },
              street_addresses: street_addresses.select { |x| x.nr == partner.addr_nr }
          }

          partner = builder_for(:partner, partner_params).build do |builder|
            builder.with_user
            builder.with_postal_addresses
            builder.with_street_addresses
          end

          partner.save if partner.changed? || partner.new_record?
          puts partner.errors.full_messages if partner.errors.any?

          @object.partners << partner
        end
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

      private

      def obtain_object
        doc = CorevistAPI::Invoice.new
        doc.doc_number = doc_nr.doc_nr
        raise CorevistAPI::ServiceException.new("api.salesdoc.doc_nr_not_found") unless doc.doc_number

        doc
      end
    end
  end
end
