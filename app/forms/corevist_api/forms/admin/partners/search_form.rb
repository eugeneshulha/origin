module CorevistAPI
  module Forms
    class Admin::Partners::SearchForm < BaseForm
      validates_with CorevistAPI::Validators::OneOutOfValidator

      def permitted_params
        %w[number name city postal_code]
      end
    end
  end
end
