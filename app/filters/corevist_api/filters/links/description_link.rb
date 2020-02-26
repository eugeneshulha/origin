module CorevistAPI
  module Filters::Links
    class DescriptionLink < BaseLink
      DESCRIPTION = 'description LIKE ?'.freeze

      def perform(data)
        return unless (description = data.params.extract!(:description))

        data.query = data.query.where(DESCRIPTION, "%#{description}%")
      end
    end
  end
end
