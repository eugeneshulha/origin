module CorevistAPI
  class RFCServices::SalesdocListRFC < CorevistAPI::RFCServices::BaseRFCService

    MAPPER = {
        DOC_NR: :doc_number,
        ITEM_NR: :item_number,
        DOC_TYPE: :doc_type,
        DOC_CAT: :doc_category,
        SA: :sales_area,
        PO_NR: :po_number,
        DOC_DATE: :doc_date,
        RDD: :req_del_date,
        CURR: :currency,
        NET_VALUE: :net_value,
        SHIP_STATUS: :ship_status,
        CREDIT_STATUS: :credit_status,
        MAT: :material,
        QTY: :quantity,
        SALES_UOM: :sales_uom,
        DESCR: :description,
        SOLD_TO_NR: :sold_to_number,
        SOLD_TO_DESCR: :sold_to_description,
        SHIP_TO_NR: :ship_to_number,
        SHIP_TO_DESCR: :ship_to_description,
        REFERENCE: :reference,
        VALID_FROM: :valid_from,
        VALID_TO: :valid_to,
        OUTPUT_TYPES: :output_types
    }

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
          ITEM_LIST => FALSE_VAL,
          TA_GROUP => '0'
        }
      }.tap do |hash|
        hash[SEARCH_CRITERIA][SOLD_TO_NR]    = @object.value_for_key(:sold_to_nr).add_leading_zeros       if @object.value_for_key(:sold_to_nr)
        hash[SEARCH_CRITERIA][SHIP_STATUS]   = @object.value_for_key(:status).add_leading_zeros           if @object.value_for_key(:status)
        hash[SEARCH_CRITERIA][MAT]           = @object.value_for_key(:material).to_s                      if @object.value_for_key(:material)
        hash[SEARCH_CRITERIA][FROM_DOC_DATE] = @object.value_for_key(:from_date).to_s                     if @object.value_for_key(:from_date)
        hash[SEARCH_CRITERIA][TO_DOC_DATE]   = @object.value_for_key(:to_date).to_s                       if @object.value_for_key(:to_date)
        hash[SEARCH_CRITERIA][PO_NR]         = @object.value_for_key(:po_number).to_s                     if @object.value_for_key(:po_number)
        hash[SEARCH_CRITERIA][INVOICE_NR]    = @object.value_for_key(:salesdoc_number).add_leading_zeros  if @object.value_for_key(:salesdoc_number)
        hash[SEARCH_CRITERIA][MY]            = 'T'                                                        if @object.value_for_key(:my)
        hash[SEARCH_CRITERIA][MAX_RESULTS]   = @object.value_for_key(:my) ? '50' : '50'
      end
    end

    def output
      super

      @data = get_function_param(SALES_DOCUMENTS).map do |invoice|
        invoice = map_params(invoice)
        RfcResultEntry.new(self.class.name.demodulize.underscore, invoice)
      end
    end

    def map_params(invoice)
      invoice.each_with_object({}) do |(k, v), memo|
        memo[MAPPER[k.to_sym].to_s] = v
      end
    end
  end
end
