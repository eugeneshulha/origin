module CorevistAPI
  class Forms::BaseForm
    include ActiveModel::Validations

    KEY_ID = 0
    VAL_ID = 1

    def initialize(params = {})
      prepare_params(params).each do |name, value|
        instance_variable_set("@#{name}", value)
        class_eval { attr_reader name.to_sym }
      end
    end

    def params_key; end

    def rejected_keys
      []
    end

    def permitted_params
      %w[current_user_id]
    end

    def validation_params
      permitted_params - %w[current_user_id]
    end

    private

    # to modify incoming params from a webservice
    def prepare_params(params)
      params = params_key.present? ? params.public_send(:require, params_key) : params
      params.permit(*permitted_params).to_hash.each_with_object({}) do |param, memo|
        memo[param[KEY_ID].underscore] = param[VAL_ID]
      end
    end
  end
end
