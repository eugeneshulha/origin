module CorevistAPI
  module Filters::Links
    class UserClassificationLink < BaseLink
      def perform(data)
        return unless (classification = data.params.extract!(:classification)).present?

        data.query = data.query.where(classification: classification)
      end
    end
  end
end
