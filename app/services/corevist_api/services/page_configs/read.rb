module CorevistAPI
  module Services::PageConfigs
    class Read < CorevistAPI::Services::BaseService
      def initialize(page_id, obj = nil)
        @page_id = page_id
        @object = obj
        @path = File.join(Rails.root, "./../../config/pages/#{@page_id}.yml")
        raise ActionController::RoutingError.new('configs not found') unless File.exists?(@path)
      end

      def call
        result(YAML.load(ERB.new(File.read(@path)).result(binding)).as_json)
      end
    end
  end
end
