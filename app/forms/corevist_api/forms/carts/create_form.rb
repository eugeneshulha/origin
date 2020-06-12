module CorevistAPI::Forms::Carts
  class CreateForm < CorevistAPI::Forms::BaseForm
    validate_component :cart_create_form, on_page: :carts_create
  end
end
