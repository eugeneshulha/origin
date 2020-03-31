module CorevistAPI
  class RFCServices::SalesdocListRFC < CorevistAPI::RFCServices::BaseRFCService
    private

    def function_name
      :salesdoc_list
    end

    def input
      rfc_object = object_to_rfc
      rfc_user = user_to_rfc(user)
      set_params(rfc_object.merge(rfc_user))
    end

    def object_to_rfc
      {
        SEARCH_CRITERIA => {
          WITH_DESCRIPTIONS => TRUE_VAL,
          MAX_RESULTS => '12000',
          ITEM_LIST => FALSE_VAL,
          TA_GROUP => '2'
        }
      }.tap do |hash|

        hash[SEARCH_CRITERIA][SEARCH_OPTION] = @params[:search_option].to_s if @params[:search_option].present?
        hash[SEARCH_CRITERIA][SOLD_TO_NR] = @params[:sold_to_nr].add_leading_zeros if @params[:sold_to_nr].present?
        hash[SEARCH_CRITERIA][MAT] = @params[:material].to_s if @params[:material].present?
        hash[SEARCH_CRITERIA][FROM_DOC_DATE] = @params[:from_date].to_s if @params[:from_date].present?
        hash[SEARCH_CRITERIA][TO_DOC_DATE] = @params[:to_date].to_s if @params[:to_date].present?
        hash[SEARCH_CRITERIA][PO_NR] = @params[:po_number].to_s if @params[:po_number].present?
        hash[SEARCH_CRITERIA][SALESDOC_NR] = @params[:salesdoc_number].add_leading_zeros if @params[:salesdoc_number].present?
      end
    end

    def output
      super

      @data = get_function_param(SALES_DOCUMENTS).map do |invoice|
        RfcResultEntry.new(self.class.name.demodulize.underscore, invoice)
      end
    end
  end
end
