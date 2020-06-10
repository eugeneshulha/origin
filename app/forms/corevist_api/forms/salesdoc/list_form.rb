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

    private

    def required_fields
      FIELD_DEPENDENCY
    end
  end
end
