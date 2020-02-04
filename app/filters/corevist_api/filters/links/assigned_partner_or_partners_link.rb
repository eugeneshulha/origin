module CorevistAPI
  module Filters::Links
    class AssignedPartnerOrPartnersLink < BaseLink
      include CorevistAPI::Filters::Common

      SOLD_TO_FUNCTION = 'AG'.freeze
      SHIP_TO_FUNCTION = 'WE'.freeze

      def perform(data)
        return unless !data.partner_number && data.object.customer_admin?

        if customer_admins_can_maintain?
          data.object.sold_tos.each { |sold_to| by_assigned_partner(sold_to.number, SOLD_TO_FUNCTION, data) }
          data.object.ship_tos.each { |ship_to| by_assigned_partner(ship_to.number, SHIP_TO_FUNCTION, data) }
        else
          data.object.assigned_sold_tos.empty? ? by_assigned_ship_tos(data) : by_assigned_sold_tos(data)
        end
      end

      private

      def customer_admins_can_maintain?
        true
      end

      def by_assigned_ship_tos(data)
        data.object.assigned_ship_tos.each { |ship_to| by_assigned_partner(ship_to, SHIP_TO_FUNCTION, data) }
      end

      def by_assigned_sold_tos(data)
        data.object.assigned_sold_tos.each { |sold_to| by_assigned_partner(sold_to, SOLD_TO_FUNCTION, data) }
      end
    end
  end
end
