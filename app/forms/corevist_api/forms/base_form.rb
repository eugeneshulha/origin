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
      check_required_fields
    end

    def check_required_fields
      return if required_fields.blank?

      s_criteria = instance_variables.select do |variable|
        required_fields.keys.include?(variable.to_s.tr('@', '').to_sym)
      end

      errors.add(:base, :invalid, message: _('error|please specify a criteria to search')) if s_criteria.empty?

      s_criteria.each do |criteria|
        dependent_fields = required_fields[criteria.to_s.tr('@', '').to_sym]
        dependent_fields.each do |df|
          errors.add(:base, :blank, message: _("error|attributes.#{df}.blank")) if send(df).blank?
        end
      end
    end

    def params_key
      nil
    end

    def required_fields
      []
    end

    private

    def init_params(_params = {})
      params = _params[params_key] || _params

      params.each do |k, v|
        next unless self.respond_to?(k)

        v = v.permit!.to_h if v.is_a?(ActionController::Parameters)
        self.send("#{k}=", v)
      end
    end
  end
end
