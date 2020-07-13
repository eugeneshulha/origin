module CorevistAPI::Forms::Carts::Items
  class UpdateForm < CorevistAPI::Forms::BaseForm
    validate_component :cart_item_update_form, on_page: :carts_items_update
  end
end
