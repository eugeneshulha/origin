module CorevistAPI
  module Filters::Chains
    class BaseChain < Array
      class IncompatibleLinkTypeError < StandardError; end

      def <<(obj)
        obj = "CorevistAPI::Filters::Links::#{obj.to_s.camelize}".safe_constantize
        raise IncompatibleLinkTypeError unless obj < CorevistAPI::Filters::Links::BaseLink

        super
      end
    end
  end
end
