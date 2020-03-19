module CorevistAPI
  class API::V1::Users::PartnersController < API::V1::BaseController
    AG = 'AG'
    WE = 'WE'
    RG = 'RG'
    FUNCTIONS = {
        AG => :sold_to,
        WE => :ship_to,
        RG => :payer
    }

    def index
      @partners = current_user.assigned_partners.inject([]) do |memo, partner|
        memo << { function: FUNCTIONS[partner.function] || partner.function, number: partner.number }
      end
    end
  end
end
