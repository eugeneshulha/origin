module CorevistAPI
  class Factories::RFCServicesFactory < Factories::BaseFactory
    def initialize
      @storage = {
          find_salesdoc: 'CorevistAPI::RFCServices::Salesdoc::DisplayRFC'
      }
    end
  end
end
