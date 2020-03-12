module CorevistAPI
  class Forms::BaseForm
    include ActiveModel::Validations
    include CorevistAPI::Factories::FactoryInterface
    include CorevistAPI::FormValidations

    attr_writer :uuid

    KEY_ID = 0
    VAL_ID = 1

    def initialize(params = {})
      init_params(params)
    end

    def params_key
      nil
    end

    private

    def init_params(_params = {})
      params = _params[params_key] || _params

      params.each { |k, v| self.send("#{k}=", v) }
    end
  end
end
