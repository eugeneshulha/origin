module CorevistAPI::Services::Carts::Items
  class DestroyService < CorevistAPI::Services::Base::DestroyService
    private

    def object_class
      CorevistAPI::Cart::Item
    end
  end
end
