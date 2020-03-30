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

      hash[SEARCH_CRITERIA][PAYER_NR] = @params[:payer].add_leading_zeros if @params[:payer].present?
      hash[SEARCH_CRITERIA][MAT] = @params[:material].to_s if @params[:material].present?
      hash[SEARCH_CRITERIA][FROM_DOC_DATE] = @params[:from_date].to_s if @params[:from_date].present?
      hash[SEARCH_CRITERIA][TO_DOC_DATE] = @params[:to_date].to_s if @params[:to_date].present?
      hash[SEARCH_CRITERIA][PO_NR] = @params[:po_number].to_s if @params[:po_number].present?
      hash[SEARCH_CRITERIA][SALESDOC_NR] = @params[:salesdoc_number].add_leading_zeros if @params[:salesdoc_number].present?
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
