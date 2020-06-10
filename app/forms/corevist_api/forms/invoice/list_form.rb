module CorevistAPI
  class Forms::Invoice::ListForm < CorevistAPI::Forms::BaseForm
    validate_component :invoice_filter_form, on_page: :invoices_index

    FIELD_DEPENDENCY = {
        payer: [:from_date, :to_date, :payer_number],
        salesdoc_number: [:salesdoc_number],
        po_number: [:po_number],
        material: [:from_date, :to_date, :material],
        invoice_number: [:invoice_number],
        delivery_number: [:delivery_number]
    }

    private

    def required_fields
      FIELD_DEPENDENCY
    end
  end
end
