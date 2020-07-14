module CorevistAPI::Services::Carts
  class GetLastActiveService < CorevistAPI::Services::BaseService
    private

    def perform
      active_cart = current_user.last_active_cart || CorevistAPI::Cart.create! do |cart|
        cart.user = current_user
        cart.sales_area = current_user.microsite.sales_areas.first
        cart.doc_type = cart.sales_area&.doc_types&.first
        cart.rdd = Date.today.date_to_rfc_str
        cart.title = DateTime.now.strftime('%Y%m%d%H%M%S')
        cart.active = true
      end

      if active_cart.partners.blank?
        active_cart.partners = %w[AG WE RG].map { |f| CorevistAPI::Cart::Partner.new(function: f, number: '3000') }
      end

      result(active_cart)
    end
  end
end
