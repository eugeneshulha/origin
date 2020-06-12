module CorevistAPI::Forms::Carts
  class SimulateForm < CorevistAPI::Forms::BaseForm
    validate_component :cart_simulate_form, on_page: :carts_simulate
  end
end
