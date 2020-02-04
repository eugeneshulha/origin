module CorevistAPI
  module Filters::Links
    class BaseLink
      def perform(data)
        raise NotImplementedError
      end
    end
  end
end
