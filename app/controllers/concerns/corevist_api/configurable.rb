module CorevistAPI
  module Configurable
    extend ActiveSupport::Concern

    included do

      def configs(page_name = nil)
        f_name = page_name || self.class&.send(:config_file_name)
        @settings = if params[:f] == 'yml'
                      path = File.join(Rails.root, "./../../config/pages/#{f_name}.yml")
                      YAML.load(ERB.new(File.read(path)).result).as_json
                    else
                      file = File.read(File.join(Rails.root, "./../../config/pages/#{f_name}.json"))
                      JSON.parse(file)
                    end
      end
    end
  end
end
