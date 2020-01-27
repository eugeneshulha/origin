module CorevistAPI
  module API::V1::Filters::Links
    class CriteriaLink < BaseLink
      ALLOWED_TO_SEARCH_CRITERIA = %w[username email last_name first_name microsite phone].freeze

      def perform(data)
        params = data.params.all.reject { |k, _| ALLOWED_TO_SEARCH_CRITERIA.exclude?(k) }
        params.each_pair { |criteria, value| data.query = data.query.where(["#{criteria} LIKE ?", "#{value}%"]) }
      end
    end
  end
end
