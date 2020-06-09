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
        %i[sold_to_number salesdoc_number invoice_number delivery_number].each do |key|
          if @object.value_for_key(key).present?
            hash[SEARCH_CRITERIA][MAPPER.key(key).to_s] = @object.value_for_key(key).add_leading_zeros
          end
        end

        %i[ship_status material from_date to_date po_number].each do |key|
          if @object.value_for_key(key).present?
            hash[SEARCH_CRITERIA][MAPPER.key(key).to_s] = @object.value_for_key(key)
          end
        end

        hash[SEARCH_CRITERIA][MY] = 'T' if @object.value_for_key(:my)
        hash[SEARCH_CRITERIA][MAX_RESULTS] = @object.value_for_key(:my) ? '50' : '12000'
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
        memo[MAPPER[k.to_sym].to_s] = v.try(:force_encoding, Encoding::UTF_8)
      end
    end
  end
end
