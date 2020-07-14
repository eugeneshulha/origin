module CorevistAPI::Services::MaterialsAvailability
  class IndexService < CorevistAPI::Services::BaseServiceWithForm

    private

    def perform
      temp_cart = CorevistAPI::Cart.new do |cart|
        cart.po_number = 'B2B_THIN_CART:PAM'
        cart.user = current_user
        cart.sales_area = current_user.microsite.sales_areas.first
        cart.doc_type = cart.sales_area&.doc_types&.first
        cart.rdd = Date.today.date_to_rfc_str
        cart.title = DateTime.now.strftime('%Y%m%d%H%M%S')
        cart.active = true
        cart.partners = [CorevistAPI::Cart::Partner.new(function: 'AG', number: '3000')]
        cart.items = @params[:items].map do |m|
          CorevistAPI::Cart::Item.new(material: m, quantity: '1', rdd: cart.rdd)
        end
      end

      @rfc_result = rfc_service_for(:salesdoc_create, temp_cart, @params).call

      result(@rfc_result.data)
    end
  end
end
