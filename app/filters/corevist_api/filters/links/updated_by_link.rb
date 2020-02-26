module CorevistAPI
  module Filters::Links
    class UpdatedByLink < BaseLink
      def perform(data)
        return unless (updated_by = data.params.extract!(:updated_by))

        data.query = data.query.where(updated_by: updated_by)
      end
    end
  end
end
