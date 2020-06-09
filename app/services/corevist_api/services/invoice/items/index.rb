module CorevistAPI::Services::Invoice::Items
  class Index < CorevistAPI::Services::Salesdoc::Items::Index
    private

    def call_rfc
      rfc_service_for(:invoice_display, @object, @params).call
    end
  end
end
