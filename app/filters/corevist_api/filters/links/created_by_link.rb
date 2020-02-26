module CorevistAPI
  module Filters::Links
    class CreatedByLink < BaseLink
      def perform(data)
        return unless (created_by = data.params.extract!(:created_by))

        data.query = data.query.where(created_by: created_by)
      end
    end
  end
end
