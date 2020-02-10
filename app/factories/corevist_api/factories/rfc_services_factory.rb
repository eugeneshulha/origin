module CorevistAPI
  class Factories::RFCServicesFactory < Factories::BaseFactory
    def initialize
      @storage = {
        find_salesdoc: 'CorevistAPI::RFCServices::Salesdoc::DisplayRFC',
        get_partner: 'CorevistAPI::RFCServices::PartnerDataRFC',
        search_partner: 'CorevistAPI::RFCServices::PartnerSearchRFC',
        truncate_rfc: 'CorevistAPI::RFCServices::Truncations::RfcService'
      }
    end
  end
end
