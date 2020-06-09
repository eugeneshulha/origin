module CorevistAPI
  module Factories
    class DownloadersFactory < BaseFactory
      def initialize
        @storage = {
          csv: 'CorevistAPI::Downloaders::Csv'
        }
      end
    end
  end
end
