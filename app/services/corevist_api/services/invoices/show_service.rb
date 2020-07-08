module CorevistAPI::Services::Invoices
  class ShowService < CorevistAPI::Services::BaseService

    private

    def perform
      @rfc_result = rfc_service_for(:invoice_display, @object, @params).call

      invoice = builder_for(:invoice, @rfc_result.data).build do |builder|
        builder.with_configs
        builder.with_items
        builder.with_header
        builder.with_prices
        builder.with_partners
      end

      invoice = prepare_response(invoice)

      result(invoice.as_json)
    end

    def prepare_response(doc)
      price_components = {
        title: _('title|pricing details'),
        content_type: 'table',
        data: doc.price_components.map do |pc|
                { title: _("lbl|cond type #{pc.cond_type}"), text: pc.value }
              end
      }

      partners = doc.partners.map do |partner|
        {
          title: _("title|partner #{partner.function}"),
          text: "#{partner.street_address_1}, #{partner.street_address_2}, #{partner.street_address_3}"
        }
      end

      doc_details = {
        title: _("title|salesdoc details"),
        data: [
          *partners,
          { title: _("lbl|sales area"), text: @rfc_result.data['header'].sa },
          { title: _('lbl|doc type'), text: @rfc_result.data['header'].doc_type }
        ]
      }

      [].tap do |arr|
        arr << price_components
        arr << doc_details
      end
    end
  end
end
