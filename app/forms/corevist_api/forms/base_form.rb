module CorevistAPI
  class Forms::BaseForm
    include ActiveModel::Validations
    include CorevistAPI::Factories::FactoryInterface

    KEY_ID = 0
    VAL_ID = 1

    def initialize(params = {})
      prepare_params(params).each do |name, value|
        instance_variable_set("@#{name}", value)
        class_eval { attr_reader name.to_sym }
      end
    end

    private

    # to modify incoming params from a webservice
    def prepare_params(params)
      params.permit!.to_hash.each_with_object({}) do |param, memo|
        memo[param[KEY_ID].underscore] = param[VAL_ID]
      end
    end
  end
end
