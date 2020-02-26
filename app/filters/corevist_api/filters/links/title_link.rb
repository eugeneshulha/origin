module CorevistAPI
  module Filters::Links
    class TitleLink < BaseLink
      def perform(data)
        return unless (title = data.params.extract!(:title))

        data.query = data.query.where(title: title)
      end
    end
  end
end
