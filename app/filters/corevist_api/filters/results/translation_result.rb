module CorevistAPI
  module Filters::Results
    class TranslationResult < BaseResult
      def initialize(params, query)
        @params = CorevistAPI::Filters::Params::BaseParams.new(params)
        @query = query
      end
    end
  end
end
