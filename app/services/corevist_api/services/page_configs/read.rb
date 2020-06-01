module CorevistAPI::Services::PageConfigs
  class Read < CorevistAPI::Services::BaseService
    def initialize(page, step: nil, object: nil)
      @page_id = page
      @object = object
      @step_id = step
      @path = File.join(Rails.root, "./../../config/pages/#{@page_id}.yml")
      raise ActionController::RoutingError.new('configs not found') unless File.exist?(@path)
    end

    def call
      result(YAML.safe_load(ERB.new(File.read(@path)).result(binding)).as_json)
    end
  end
end
