module CorevistAPI::Services::Carts::Items
  class UpdateService < CorevistAPI::Services::Base::UpdateService
    private

    def object_class
      CorevistAPI::Cart::Item
    end
  end
end
