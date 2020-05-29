module CorevistAPI
  module Filters::Links
    class PartnersLink < BaseLink
      def perform(data)
        return if data.partners.blank?

        data.query = data.query.joins(:partners)&.where(partners: data.partners.reduce(:or))
      end
    end
  end
end
