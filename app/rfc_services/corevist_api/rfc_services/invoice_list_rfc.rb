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
      {
        SEARCH_CRITERIA => {
          PAYER_NR => @params[:payer].add_leading_zeros,
          MAT => @params[:material].to_s,
          FROM_DOC_DATE => @params[:from_date].to_s,
          TO_DOC_DATE => @params[:to_date].to_s,
          PO_NR => @params[:po_number].to_s,
          SALESDOC_NR => @params[:doc_number].add_leading_zeros
        }
      }
    end

    def output
      super

      @data = get_function_param(INVOICES).map do |invoice|
        RfcResultEntry.new(self.class.name.demodulize.underscore, invoice)
      end
    end
  end
end
