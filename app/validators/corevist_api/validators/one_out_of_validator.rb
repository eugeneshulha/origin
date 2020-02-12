module CorevistAPI
  module Validators
    class OneOutOfValidator < ActiveModel::Validator
      AT_SIGN = '@'.freeze

      def validate(record)
        return if (variables_names(record) & record.permitted_params).present?

        record.errors.add(:parameter, I18n.t('api.forms.no_param'))
      end

      private

      def variables_names(record)
        record.instance_variables.map { |var| var.to_s.delete(AT_SIGN) }
      end
    end
  end
end
