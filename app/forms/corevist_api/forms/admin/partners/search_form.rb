module CorevistAPI
  module Forms
    class Admin::Partners::SearchForm < BaseForm
      include VariablesNames

      validates_with CorevistAPI::Validators::AtLeastOneParamValidator

      def self.permitted_params
        super + %w[number name city postal_code]
      end
    end
  end
end
