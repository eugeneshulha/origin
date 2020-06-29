module CorevistAPI
  class Factories::RFCServicesFactory < Factories::BaseFactory
    def initialize
      @storage = {
        assigned_partners: 'CorevistAPI::RFCServices::AssignedPartnersRFC',
        get_partner: 'CorevistAPI::RFCServices::PartnerDataRFC',
        get_pdf: 'CorevistAPI::RFCServices::GetPdfRFC',
        invoice_display: 'CorevistAPI::RFCServices::InvoiceDisplayRFC',
        invoice_list: 'CorevistAPI::RFCServices::InvoiceListRFC',
        open_items: 'CorevistAPI::RFCServices::OpenItemsRFC',
        partner_search: 'CorevistAPI::RFCServices::PartnerSearchRFC',
        pay_invoices: 'CorevistAPI::RFCServices::PayBillRFC',
        salesdoc_create: 'CorevistAPI::RFCServices::SalesdocCreateRFC',
        salesdoc_display: 'CorevistAPI::RFCServices::SalesdocDisplayRFC',
        salesdoc_list: 'CorevistAPI::RFCServices::SalesdocListRFC',
        payments_list: 'CorevistAPI::RFCServices::PaymentsListRFC',
        truncate_rfc: 'CorevistAPI::RFCServices::Truncations::RfcService'
      }
    end
  end
end
