module CorevistAPI
  module Constants
    module SAP::Common
      # sp - sold-to
      # sh - ship-to
      # py - payer
      FUNCTIONS_MAP = {
          sp: :AG,
          sh: :WE
      }.freeze
    end
  end
end
