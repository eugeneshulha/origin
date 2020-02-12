module CorevistAPI
  module FormValidations
    ARRAY_KEY = 'array'.freeze

    def self.included(base)
      base.define_singleton_method :validate_form do
        path = CorevistAPI::Engine.root.join('config', 'validations', model_name.route_key + '.yml').to_s
        configs = YAML.load_file(path)

        attr_accessor(*configs.keys)

        define_method(:permitted_params) { prepared_keys(configs) }

        configs.each do |field, validations|
          validations.each do |options|
            next if options[0] == ARRAY_KEY

            validation = Hash[*options]
            validation = validation.deep_symbolize_keys if options.second.is_a?(Hash)

            base.validates field, validation
          end
        end
      end
    end

    def prepared_keys(configs)
      array_keys = configs.select { |_, v| v[ARRAY_KEY] }.keys
      configs.keys.tap do |configs_keys|
        array_keys.each { |array_key| configs_keys[configs_keys.index(array_key)] = { array_key => [] } }
      end
    end
  end
end
