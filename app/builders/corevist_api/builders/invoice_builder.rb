module CorevistAPI
  module Builders
    class InvoiceBuilder < CorevistAPI::Builders::BaseBuilder
      MAX_ADDRESSES_COUNT = 3

      def with_header
        sap_field_mapper_for(:invoice, :header).each { |k,v| @object.header.send("#{v}=", header.send(k)) }
      end

      def with_items
        items.inject(@object.items) do |memo, _item|
          # TODO: move to a invoice item builder.
          item = CorevistAPI::Invoice::Item.new

          sap_field_mapper_for(:invoice, :item).each do |k,v|
            value = _item.send(k).respond_to?(:force_encoding) ? _item.send(k).force_encoding(Encoding::UTF_8) : _item.send(k)
            item.send("#{v}=", value)
          end

          item.currency = header.curr

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
              postal_addresses: postal_addresses.select { |x| x.nr == partner.nr },
              street_addresses: street_addresses.select { |x| x.nr == partner.nr }
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
          component.currency = _component.runit
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
