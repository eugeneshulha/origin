module CorevistAPI
  module Filters::Results
    class BaseResult
      attr_accessor :query
      attr_reader :params, :object

      def initialize(object, params, query)
        @object = object
        @params = CorevistAPI::Filters::Params::BaseParams.new(params)
        @query = query
      end

      def data
        @query
      end
    end
  end
end
