module CorevistAPI
  module Downloaders
    class Base
      attr_reader :objects, :params

      def initialize(objects, params)
        @objects = objects
        @params = params
      end

      def download
        raise NotImplementedError
      end

      def file_type
        raise NotImplementedError
      end

      def filename
        raise NotImplementedError
      end
    end
  end
end
