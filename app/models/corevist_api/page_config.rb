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

    def multiform_search_for(on_step, comp_id)
      multiforms = components.where(type: 'multiform')
      _step = multiforms.collect {|x| x.components.find_one_by(uuid: on_step.to_s) }&.first
      _step&.components&.find_one_by(uuid: comp_id.to_s)
    end

    private

    def skip_config?
      %w[button link].include?(self.atom)
    end

    def define_accessor(base)
      base.send(:attr_accessor, self.uuid)
    end

    def define_validations(base)
      return if self.validations.blank?

      self.validations.each do |validation|
        base.validates_with(*validation_for(self.name, validation))
      end
    end
  end
end