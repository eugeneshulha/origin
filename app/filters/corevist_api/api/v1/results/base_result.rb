module CorevistAPI
  module API::V1::Filters::Results
    class BaseResult
      attr_accessor :query
      attr_reader :params, :object

      def initialize(object, params, query)
        @object = object
        @params = CorevistAPI::API::V1::Filters::Params::BaseParams.new(params)
        @query = query
      end

      def data
        @query
      end
    end
  end
end
