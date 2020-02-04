module CorevistAPI
  module Filters
    class BaseFilter
      class EmptyFilterChainError < StandardError; end

      def initialize(object, params, query)
        @result = CorevistAPI::Filters::Results::BaseResult.new(object, params, query)
      end

      def self.chain
        class_variable_set(:@@chain, CorevistAPI::Filters::Chains::BaseChain.new)
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
