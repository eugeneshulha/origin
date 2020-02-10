module CorevistAPI
  module Validators
    class AtLeastOneParamValidator < ActiveModel::Validator
      def validate(record)
        return if (record.variables_names & record.class.validation_params).present?

        record.errors.add(:parameter, I18n.t('api.forms.no_param'))
      end
    end
  end
end
