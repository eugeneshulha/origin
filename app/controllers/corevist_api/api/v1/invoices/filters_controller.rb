module CorevistAPI
  class API::V1::Invoices::FiltersController < API::V1::BaseController
    def new
      @result = service_for(:page_configs_read, :filter_invoices_modal).call
    end
  end
end
