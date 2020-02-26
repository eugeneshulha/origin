module CorevistAPI
  module Filters::Links
    class ActiveLink < BaseLink
      def perform(data)
        return unless (active = data.params.extract!(:active))

        data.query = data.query.where(active: active)
      end
    end
  end
end
