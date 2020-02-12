module CorevistAPI
  module Factories
    class BuildersFactory < BaseFactory
      def initialize
        @storage = {
          partner_builder: 'CorevistAPI::Builders::Partners::Builder'
        }
      end
    end
  end
end
