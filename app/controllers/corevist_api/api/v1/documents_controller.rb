module CorevistAPI
  class API::V1::DocumentsController < API::V1::BaseController
    def index
      name = :search_invoices # should be a mapper
      form = FormsFactory.instance.for(name, params)
      service = ServicesFactory.instance.for(name, form)
      @result = service.call
    end

    def show
      service = ServicesFactory.instance.for(:find_invoice, params)
      @result = service.call
    end
  end
end
