module CorevistAPI
  module Forms::VariablesNames
    extend ActiveSupport::Concern

    AT_SIGN = '@'.freeze

    def variables_names
      instance_variables.map { |var| var.to_s.delete(AT_SIGN) }
    end
  end
end
