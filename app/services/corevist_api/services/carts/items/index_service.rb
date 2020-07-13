module CorevistAPI::Services::Carts::Items
  class IndexService < CorevistAPI::Services::Base::IndexService
    private

    def filter
      result(CorevistAPI::Cart::Item.where(cart_uuid: @params[:cart_uuid]))
    end
  end
end
