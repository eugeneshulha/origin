module CorevistAPI::Services::Invoices::Items
  class IndexService < CorevistAPI::Services::Salesdoc::Items::Index
    private

    def call_rfc
      rfc_service_for(:invoice_display, @object, @params).call
    end
  end
end
