module CorevistAPI
  module API::V1::Filters::Chains
    class BaseChain < Array
      class IncompatibleLinkTypeError < StandardError; end

      def <<(obj)
        obj = "CorevistAPI::API::V1::Filters::Links::#{obj.to_s.camelize}".safe_constantize
        raise IncompatibleLinkTypeError unless obj < CorevistAPI::API::V1::Filters::Links::BaseLink

        super
      end
    end
  end
end
