module CorevistAPI
  module FormValidations
    ARRAY_KEY = 'array'.freeze
    ARRAY_OF_HASHES_KEY = 'array_of_hashes'.freeze
    FIELDS_KEY = 'fields'.freeze

    def self.included(base)
      validate_me!(base)
    end

    def self.validate_me!(base)
      path = CorevistAPI::Engine.root.join('config', 'validations', base.model_name.route_key + '.yml').to_s
      configs = YAML.load_file(path)

      attr_accessor(*configs.keys)

      configs.each do |field, validations|
        validations.each do |options|
          next if options[0] == ARRAY_KEY || options[0] == ARRAY_OF_HASHES_KEY

          validation = Hash[*options]
          validation = validation.deep_symbolize_keys if options.second.is_a?(Hash)

          base.validates field, validation
        end
      end
    end

    def prepared_keys(configs)
      array_keys = configs.select { |_, v| v[ARRAY_KEY] }.keys
      array_of_hashes_keys = configs.select { |_, v| v[ARRAY_OF_HASHES_KEY] }.keys
      configs.keys.tap do |configs_keys|
        array_keys.each { |array_key| configs_keys[configs_keys.index(array_key)] = { array_key => [] } }
        array_of_hashes_keys.each do |key|
          configs_keys[configs_keys.index(key)] = { key => configs[key][ARRAY_OF_HASHES_KEY][FIELDS_KEY] }
        end
      end
    end
  end
end
