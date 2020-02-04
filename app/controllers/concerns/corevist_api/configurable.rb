module CorevistAPI
  module Configurable
    extend ActiveSupport::Concern

    included do

      def configs
        f_name = self.class&.send(:config_file_name)
        file = File.read("./../../config/pages/#{f_name}.json")
        @settings = JSON.parse(file)
      end
    end
  end
end
