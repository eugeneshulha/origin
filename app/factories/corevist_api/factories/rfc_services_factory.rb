module CorevistAPI
  class Factories::RFCServicesFactory < Factories::BaseFactory
    def initialize
      @storage = {
        salesdoc_display: 'CorevistAPI::RFCServices::SalesdocDisplayRFC',
        invoice_display: 'CorevistAPI::RFCServices::InvoiceDisplayRFC',
        get_partner: 'CorevistAPI::RFCServices::PartnerDataRFC',
        partner_search: 'CorevistAPI::RFCServices::PartnerSearchRFC',
        truncate_rfc: 'CorevistAPI::RFCServices::Truncations::RfcService',
        open_items: 'CorevistAPI::RFCServices::OpenItemsRFC',
        summary: 'CorevistAPI::RFCServices::SummaryRFC'
      }
    end
  end
end
