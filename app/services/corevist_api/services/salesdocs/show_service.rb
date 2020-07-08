module CorevistAPI::Services::Salesdocs
  class ShowService < CorevistAPI::Services::BaseService
    private

    def perform
      @rfc_result = rfc_service_for(:salesdoc_display, @object, @params).call

      salesdoc = builder_for(:salesdoc, @rfc_result.data).build do |builder|
        builder.with_configs
        builder.with_items
        builder.with_header
        builder.with_prices
        builder.with_partners
        builder.with_deliveries
      end

      salesdoc = prepare_response(salesdoc)

      result(salesdoc.as_json)
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

      deliveries = if doc.deliveries.present?
                     {
                       title: _('title|deliveries details'),
                       content_type: 'table',
                       data: doc.deliveries.map do |delivery|
                               {
                                 status: delivery.status,
                                 delivery_date: delivery.delivery_date,
                                 delivery_number: delivery.number,
                                 carrier: delivery.carrier_number,
                                 tracking_number: delivery.tracking_number
                               }
                             end
                     }
                   else []
                   end


      [].tap do |arr|
        arr << price_components
        arr << doc_details
        arr << deliveries if deliveries.present?
      end
    end
  end
end
