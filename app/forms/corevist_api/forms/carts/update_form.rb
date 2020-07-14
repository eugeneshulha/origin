module CorevistAPI::Forms::Carts
  class UpdateForm < CorevistAPI::Forms::BaseForm
    validate_component :cart_update_form, on_page: :carts_update
  end
end
