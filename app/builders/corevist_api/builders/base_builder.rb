module CorevistAPI
  module Builders
    class BaseBuilder
      include CorevistAPI::Factories::FactoryInterface

      def initialize(params = {})
        @params = params.is_a?(Hash) ? params.with_indifferent_access : params
        begin
          @object = obtain_object
        rescue StandardError => e
          raise e.message
        end
      end

      def build
        yield(self)
        @object
      end

      def method_missing(method, *args, &block)
        return super unless @params.key?(method)

        @params[method]
      end

      def respond_to_missing?(method, *args)
        @params.key?(method) || super
      end

      private

      def obtain_object
        raise NotImplementedError
      end
    end
  end
end
