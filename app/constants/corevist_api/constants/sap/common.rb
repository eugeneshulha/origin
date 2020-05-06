module CorevistAPI
  module Constants
    module SAP::Common
      # sp - sold-to
      # sh - ship-to
      # py - payer
      PARTNER_FUNCTIONS_MAP = {
          sp: :AG,
          sh: :WE,
          py: :RG
      }.freeze

      FUNCTION_TO_NAMES_MAP = {
          'WE' => 'ship_to',
          'AG' => 'sold_to',
          'RG' => 'payer'
      }.freeze
    end
  end
end
