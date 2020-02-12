module CorevistAPI
  module Builders
    class BaseBuilder
      def initialize(params = {})
        @params = params.with_indifferent_access
        begin
          @object = obtain_object(params)
        rescue StandardError => e
          raise "Class not provided for builder. #{e.message}"
        end
      end

      def build
        raise NotImplementedError
      end

      def method_missing(method, *args, &block)
        return super unless @params.key?(method)

        @params[method]
      end

      def respond_to_missing?(method, *args)
        @params.key?(method) || super
      end

      private

      def obtain_object(klass)
        raise NotImplementedError
      end
    end
  end
end
