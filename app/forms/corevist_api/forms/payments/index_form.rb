module CorevistAPI
  class Forms::Payments::IndexForm < CorevistAPI::Forms::BaseForm
    validate_component :payments_index_form, on_page: :payments_index
  end
end
