module CorevistAPI
  module API::V1::Filters::Links
    class AssignedPartnerLink < BaseLink
      include CorevistAPI::API::V1::Filters::Common

      SOLD_TO_FUNCTION = 'AG'.freeze
      SHIP_TO_FUNCTION = 'WE'.freeze
      PARTNER_FUNCTIONS = {
        sold_to: SOLD_TO_FUNCTION,
        ship_to: SHIP_TO_FUNCTION
      }.freeze

      def perform(data)
        PARTNER_FUNCTIONS.each_pair do |partner, function|
          next unless (data.partner_number = data.params.get("#{partner}_number".to_sym).present?)

          by_assigned_partner(data.params.extract!("#{partner}_number".to_sym), function, data)
        end
      end
    end
  end
end
