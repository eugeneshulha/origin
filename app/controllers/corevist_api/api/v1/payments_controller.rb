module CorevistAPI
  class API::V1::PaymentsController < API::V1::BaseController

    def new
      @result = service_for(:page_configs_read, :new_payment).call
    end

    def create
      form = form_for(:pay_invoices, params)
      service = service_for(:pay_invoices, form, params)
      @result = service.call
    end
  end
end
