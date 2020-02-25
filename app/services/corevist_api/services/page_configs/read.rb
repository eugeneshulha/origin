module CorevistAPI
  module Services::PageConfigs
    class Read < CorevistAPI::Services::BaseService
      def initialize(params)
        @params = params
      end

      def call
        f_name = config_for(@params[:page_id])
        path = File.join(Rails.root, "./../../config/pages/#{f_name}.yml")
        raise ActionController::RoutingError.new('configs not found') unless File.exists?(path)

        result(YAML.load(ERB.new(File.read(path)).result).as_json)
      end
    end
  end
end
