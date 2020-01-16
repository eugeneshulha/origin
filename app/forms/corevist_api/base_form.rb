module CorevistAPI
  class BaseForm
    include ActiveModel::Validations

    def initialize(params = {})
      prepare_params(params).each do |name, value|
        next unless respond_to?(name)

        instance_variable_set("@#{name}", value)
      end
    end

    def params_key
      raise NotImplementedError
    end

    private

    # to modify incoming params from a webservice
    def prepare_params(params)
      params.permit!.to_hash.inject({}) do |memo, param|
        memo[param[0].underscore] = param[1]
        memo
      end
    end
  end
end
