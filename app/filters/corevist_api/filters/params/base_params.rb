module CorevistAPI
  module Filters::Params
    class BaseParams
      def initialize(data)
        @data = data
      end

      def extract!(param)
        @data.delete(param)
      end

      def exists?(param)
        @data.key?(param)
      end

      def get(param)
        @data[param]
      end

      def all
        @data
      end
    end
  end
end
