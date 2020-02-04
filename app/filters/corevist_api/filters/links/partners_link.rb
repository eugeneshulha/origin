module CorevistAPI
  module Filters::Links
    class PartnersLink < BaseLink
      def perform(data)
        return if data.partners.blank?

        data.query = data.query.joins(:assigned_partners)&.where(assigned_partners: data.partners.reduce(:or))
      end
    end
  end
end
