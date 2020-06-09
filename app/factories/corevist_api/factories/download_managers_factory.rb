module CorevistAPI
  module Factories
    class DownloadManagersFactory < BaseFactory
      def initialize
        @storage = {
          csv: 'CorevistAPI::Managers::Download::Csv'
        }
      end
    end
  end
end
