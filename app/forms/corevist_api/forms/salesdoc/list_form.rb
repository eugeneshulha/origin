module CorevistAPI
  class Forms::Salesdoc::ListForm < CorevistAPI::Forms::BaseForm
    validate_component :salesdoc_filter_form, on_page: :salesdocs_index

    FIELD_DEPENDENCY = {
        sold_to_number: [:from_date, :to_date, :sold_to_number, :status],
        ship_to_number: [:from_date, :to_date, :ship_to_number, :status],
        po_number: [:po_number],
        material: [:from_date, :to_date, :material, :status],
        invoice_number: [:invoice_number],
        delivery_number: [:delivery_number]
    }

    def initialize(params = {})
      super
      check_required_fields
    end

    def check_required_fields
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

    def required_fields
      FIELD_DEPENDENCY
    end
  end
end
