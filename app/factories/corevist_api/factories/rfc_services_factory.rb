module CorevistAPI
  class Factories::RFCServicesFactory < Factories::BaseFactory
    def initialize
      @storage = {
        salesdoc_display: 'CorevistAPI::RFCServices::SalesdocDisplayRFC',
        salesdoc_list: 'CorevistAPI::RFCServices::SalesdocListRFC',
        invoice_display: 'CorevistAPI::RFCServices::InvoiceDisplayRFC',
        invoice_list: 'CorevistAPI::RFCServices::InvoiceListRFC',
        get_partner: 'CorevistAPI::RFCServices::PartnerDataRFC',
        partner_search: 'CorevistAPI::RFCServices::PartnerSearchRFC',
        truncate_rfc: 'CorevistAPI::RFCServices::Truncations::RfcService',
        open_items: 'CorevistAPI::RFCServices::OpenItemsRFC',
        summary: 'CorevistAPI::RFCServices::SummaryRFC',
        get_pdf: 'CorevistAPI::RFCServices::GetPdfRFC',
        pay_invoices: 'CorevistAPI::RFCServices::PayBillRFC'
      }
    end
  end
end
