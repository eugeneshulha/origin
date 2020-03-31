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
        hash[SEARCH_CRITERIA][SOLD_TO_NR]    = @object.value_for(:sold_to_nr).add_leading_zeros       if @object.value_for(:sold_to_nr)
        hash[SEARCH_CRITERIA][SHIP_STATUS]   = @object.value_for(:status).add_leading_zeros           if @object.value_for(:status)
        hash[SEARCH_CRITERIA][MAT]           = @object.value_for(:material).to_s                      if @object.value_for(:material)
        hash[SEARCH_CRITERIA][FROM_DOC_DATE] = @object.value_for(:from_date).to_s                     if @object.value_for(:from_date)
        hash[SEARCH_CRITERIA][TO_DOC_DATE]   = @object.value_for(:to_date).to_s                       if @object.value_for(:to_date)
        hash[SEARCH_CRITERIA][PO_NR]         = @object.value_for(:po_number).to_s                     if @object.value_for(:po_number)
        hash[SEARCH_CRITERIA][SALESDOC_NR]   = @object.value_for(:salesdoc_number).add_leading_zeros  if @object.value_for(:salesdoc_number)
        hash[SEARCH_CRITERIA][MY]            = 'T' if @object.value_for(:my)
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
