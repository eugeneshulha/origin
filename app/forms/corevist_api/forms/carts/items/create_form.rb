module CorevistAPI::Forms::Carts::Items
  class CreateForm < CorevistAPI::Forms::BaseForm
    validate_component :cart_item_create_form, on_page: :carts_items_create
  end
end
