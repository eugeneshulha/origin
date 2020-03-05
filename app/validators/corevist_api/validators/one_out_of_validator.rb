module CorevistAPI
  module Validators
    class OneOutOfValidator < ActiveModel::Validator
      AT_SIGN = '@'.freeze

      def validate(record)
        return if (variables_names(record) & one_out_of_params(record)).present?

        record.errors.add(:parameter, I18n.t('api.forms.no_param'))
      end

      private

      def variables_names(record)
        record.instance_variables.map { |var| var.to_s.delete(AT_SIGN) }
      end

      def one_out_of_params(record)
        raise ArgumentError unless record.respond_to?(__method__)

        record.public_send(__method__)
      end
    end
  end
end
