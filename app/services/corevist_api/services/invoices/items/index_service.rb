module CorevistAPI::Services::Invoices::Items
  class IndexService < CorevistAPI::Services::Salesdocs::Items::IndexService
    private

    def call_rfc
      rfc_service_for(:invoice_display, @object, @params).call
    end
  end
end
