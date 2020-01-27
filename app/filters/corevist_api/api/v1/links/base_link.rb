module CorevistAPI
  module API::V1::Filters::Links
    class BaseLink
      def perform(data)
        raise NotImplementedError
      end
    end
  end
end
