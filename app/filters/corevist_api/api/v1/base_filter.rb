module CorevistAPI
  module API::V1::Filters
    class BaseFilter
      class EmptyFilterChainError < StandardError; end

      def initialize(object, params, query)
        @result = CorevistAPI::API::V1::Filters::Results::BaseResult.new(object, params, query)
      end

      def self.chain
        class_variable_set(:@@chain, CorevistAPI::API::V1::Filters::Chains::BaseChain.new)
      end

      def chain_links
        raise EmptyFilterChainError if chain.blank?

        chain
      end

      def run
        chain_links.each_with_object(@result) { |link, result| link.new.perform(result) }
      end

      private

      def chain
        self.class.class_variable_get(:@@chain)
      end
    end
  end
end
