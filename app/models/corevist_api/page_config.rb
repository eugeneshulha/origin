require 'misc/find_one_by'

module CorevistAPI
  class PageConfig < OpenStruct
    include CorevistAPI::Factories::FactoryInterface
    include CorevistAPI::FindOneBy

    def transform(base)
      return if skip_config?

      define_accessor(base)
      define_validations(base)
    end

    private

    def skip_config?
      %w[button link].include?(self.atom)
    end

    def define_accessor(base)
      base.send(:attr_accessor, self.name)
    end

    def define_validations(base)
      return if self.validations.blank?

      self.validations.each do |validation|
        next if validation.type == 'is_a'

        base.validates_with(*validation_for(self.name, validation))
      end
    end
  end
end
