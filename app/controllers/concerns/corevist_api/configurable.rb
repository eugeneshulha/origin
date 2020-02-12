module CorevistAPI
  module Configurable
    extend ActiveSupport::Concern

    included do

      def configs(page_name = nil)
        f_name = page_name || self.class&.send(:config_file_name)
        file = File.read(File.join(Rails.root, "./../../config/pages/#{f_name}.json"))
        @settings = JSON.parse(file)
      end
    end
  end
end
