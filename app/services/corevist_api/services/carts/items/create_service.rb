module CorevistAPI::Services::Carts::Items
  class CreateService < CorevistAPI::Services::Base::CreateService
    private

    def object_class
      CorevistAPI::Cart::Item
    end
  end
end
