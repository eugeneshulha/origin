module CorevistAPI
  class RFCServices::InvoiceListRFC < CorevistAPI::RFCServices::BaseRFCService
    def initialize(*)
      super
    end

    private

    def function_name
      :invoice_list
    end

    def input
      rfc_object = object_to_rfc
      rfc_user = user_to_rfc(user)
      set_params(rfc_object.merge(rfc_user))
    end

    def object_to_rfc
      hash = {
          SEARCH_CRITERIA => {
          WITH_DESCRIPTIONS => 'T',
          MAX_RESULTS => '12000',
          ITEM_LIST => 'F',
          RFC_FLAGS => 'A'
        }
      }

      hash[SEARCH_CRITERIA][PAYER_NR]      = @object.value_for(:payer).add_leading_zeros            if @object.value_for(:payer)
      hash[SEARCH_CRITERIA][MAT]           = @object.value_for(:material).to_s                      if @object.value_for(:material)
      hash[SEARCH_CRITERIA][FROM_DOC_DATE] = @object.value_for(:from_date).to_s                     if @object.value_for(:from_date)
      hash[SEARCH_CRITERIA][TO_DOC_DATE]   = @object.value_for(:to_date).to_s                       if @object.value_for(:to_date)
      hash[SEARCH_CRITERIA][PO_NR]         = @object.value_for(:po_number).to_s                     if @object.value_for(:po_number)
      hash[SEARCH_CRITERIA][SALESDOC_NR]   = @object.value_for(:salesdoc_number).add_leading_zeros  if @object.value_for(:salesdoc_number)
      hash
    end

    def output
      super

      @data = get_function_param(INVOICES).map do |invoice|
        RfcResultEntry.new(self.class.name.demodulize.underscore, invoice)
      end
    end
  end
end
