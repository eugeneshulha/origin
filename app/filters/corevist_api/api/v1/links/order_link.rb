module CorevistAPI
  module API::V1::Filters::Links
    class OrderLink < BaseLink
      SORT_COLUMN = 'username'.freeze
      SORT_ORDER = 'asc'.freeze
      SORT_SEPARATOR = ' '.freeze

      def perform(data)
        data.query = data.query.order([SORT_COLUMN, SORT_ORDER].join(SORT_SEPARATOR))&.uniq
      end
    end
  end
end
