module CorevistAPI
  module FormValidations

    def self.included(base)
      base.define_singleton_method :validate_form do
        path = CorevistAPI::Engine.root.join('config', 'validations', self.model_name.route_key + '.yml').to_s
        configs = YAML.load_file(path)

        attr_accessor *configs.keys

        configs.each do |field, validations|
          validations.each do |options|
            validation = Hash[*options]
            validation =  validation.deep_symbolize_keys if options.second.is_a?(Hash)

            base.validates field, validation
          end
        end
      end
    end
  end
end
