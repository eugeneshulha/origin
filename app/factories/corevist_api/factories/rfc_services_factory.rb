module CorevistAPI
  class Factories::RFCServicesFactory < Factories::BaseFactory
    def initialize
      @storage = {
        salesdoc_display: 'CorevistAPI::RFCServices::SalesdocDisplayRFC',
        get_partner: 'CorevistAPI::RFCServices::PartnerDataRFC',
        partner_search: 'CorevistAPI::RFCServices::PartnerSearchRFC',
        truncate_rfc: 'CorevistAPI::RFCServices::Truncations::RfcService'
      }
    end
  end
end
