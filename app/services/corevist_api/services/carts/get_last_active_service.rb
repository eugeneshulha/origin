module CorevistAPI::Services::Carts
  class GetLastActiveService < CorevistAPI::Services::BaseService
    private

    def perform
      result(current_user.last_active_cart || CorevistAPI::Cart.create do |cart|
        cart.user = current_user
        cart.sales_area = current_user.microsite.sales_areas.first
        cart.doc_type = cart.sales_area&.doc_types&.first
        cart.rdd = Date.today.date_to_rfc_str
        cart.title = DateTime.now.strftime('%Y%m%d%H%M%S')
        cart.active = true
      end)
    end
  end
end
