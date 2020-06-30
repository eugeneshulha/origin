module CorevistAPI
  class Factories::SAPFieldsMappersFactory < Factories::BaseFactory
    def initialize
      @storage = Settings.sap_ruby_mappings.to_hash.with_indifferent_access
    end

    def for(name, args = [])
      mapping = @storage[name]
      raise StandardError.new(_('error|no mappings found')) unless mapping
      return mapping if args.blank?

      mapping.dig(*args)
    end
  end
end
