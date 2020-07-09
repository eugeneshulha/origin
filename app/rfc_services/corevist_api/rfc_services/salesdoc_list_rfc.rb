module CorevistAPI
  class RFCServices::SalesdocListRFC < CorevistAPI::RFCServices::BaseRFCService

    MAPPER = {
      CREDIT_STATUS: :credit_status,
      CURR: :currency,
      DESCR: :description,
      DOC_CAT: :doc_category,
      DOC_DATE: :doc_date,
      DOC_NR: :doc_number,
      DOC_TYPE: :doc_type,
      FROM_DOC_DATE: :from_date,
      INVOICE_NR: :salesdoc_number,
      ITEM_NR: :item_number,
      MAT: :material,
      NET_VALUE: :net_value,
      OUTPUT_TYPES: :output_types,
      DEL_NR: :delivery_number,
      PO_NR: :po_number,
      INV_NR: :invoice_number,
      QTY: :quantity,
      RDD: :req_del_date,
      REFERENCE: :reference,
      SA: :sales_area,
      SALES_UOM: :sales_uom,
      SHIP_STATUS: :ship_status,
      SHIP_TO_DESCR: :ship_to_description,
      SHIP_TO_NR: :ship_to_number,
      SOLD_TO_DESCR: :sold_to_description,
      SOLD_TO_NR: :sold_to_number,
      TO_DOC_DATE: :to_date,
      VALID_FROM: :valid_from,
      VALID_TO: :valid_to
    }.freeze

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
        hash[SEARCH_CRITERIA][SOLD_TO_NR] = @object.value_for_key(:sold_to_number).add_leading_zeros if @object.value_for_key(:sold_to_number).present?
        hash[SEARCH_CRITERIA][INV_NR] = @object.value_for_key(:invoice_number).add_leading_zeros if @object.value_for_key(:invoice_number).present?
        hash[SEARCH_CRITERIA][DEL_NR] = @object.value_for_key(:delivery_number).add_leading_zeros if @object.value_for_key(:delivery_number).present?

        hash[SEARCH_CRITERIA][SHIP_STATUS] = @object.value_for_key(:ship_status) if @object.value_for_key(:ship_status).present?
        hash[SEARCH_CRITERIA][MAT] = @object.value_for_key(:material) if @object.value_for_key(:material).present?
        hash[SEARCH_CRITERIA][FROM_DOC_DATE] = @object.value_for_key(:from_date) if @object.value_for_key(:from_date).present?
        hash[SEARCH_CRITERIA][TO_DOC_DATE] = @object.value_for_key(:to_date) if @object.value_for_key(:to_date).present?
        hash[SEARCH_CRITERIA][PO_NR] = @object.value_for_key(:po_number) if @object.value_for_key(:po_number).present?

        hash[SEARCH_CRITERIA][MY] = 'T' if @object.value_for_key(:my)
        hash[SEARCH_CRITERIA][MAX_RESULTS] = @object.value_for_key(:my) ? '50' : '12000'
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
