module CorevistAPI
  module Services::PageConfigs
    class Navigation < CorevistAPI::Services::BaseService
      def initialize(page, step: nil, object: nil)
        @page_id = page
        @object = object
        @step_id = step
        @path = File.join(Rails.root, "./../../config/pages/#{@page_id}.yml")
        raise ActionController::RoutingError.new('configs not found') unless File.exist?(@path)
      end

      def call
        file = YAML.safe_load(ERB.new(File.read(@path)).result(binding))

        # Check high-level tabs
        check_permissions(file['navigationLinks'])

        # Check submenus
        file['navigationLinks'].each do |link|
          check_permissions(link['subCategories']) if link['subCategories'].present?
        end

        # Exclude admin tab if it's submenus is empty
        file['navigationLinks'].reject! { |item| item['uuid'] == 'admin' && item['subCategories'].blank? }

        result(file.as_json)
      end

      private

      def check_permissions(hash)
        hash.select! { |item| item['permission'].blank? || current_user.authorized_for?(item['permission']) }
      end
    end
  end
end
