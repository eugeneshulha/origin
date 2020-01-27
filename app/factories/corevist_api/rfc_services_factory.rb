module CorevistAPI
  class RFCServicesFactory < BaseFactory
    def initialize
      @storage = {
          find_salesdoc: 'CorevistAPI::RFCServices::Salesdoc::DisplayRFC'
      }
    end
  end
end
