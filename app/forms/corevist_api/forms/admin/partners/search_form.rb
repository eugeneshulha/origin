module CorevistAPI
  module Forms
    class Admin::Partners::SearchForm < BaseForm
      validates_with CorevistAPI::Validators::OneOutOfValidator

      def one_out_of_params
        %w[number name city postal_code]
      end
    end
  end
end
