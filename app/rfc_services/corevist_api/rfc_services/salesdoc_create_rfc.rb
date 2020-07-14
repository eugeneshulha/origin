module CorevistAPI
  class RFCServices::SalesdocCreateRFC < CorevistAPI::RFCServices::BaseRFCService
    def function_name
      :salesdoc_create
    end

    def input
      rfc_object = object_to_rfc
      rfc_user = user_to_rfc(user)
      set_params(rfc_object.merge!(rfc_user))
    end

    def object_to_rfc
      {
        HEADER_IN => {
          DOC_TYPE => @object.doc_type&.title,
          SA => @object.sales_area&.title,
          RDD => @object.rdd,
          VALID_FROM => '00000000',
          VALID_TO => '00000000',
          PO_NR => @params[:po_number].to_s,
          DEL_BLOCK => '',
          FLAGS => 'PU',
          PHONE => '1',
          REF_DOC_NR => '',
          REF_DOC_CAT => '',
          TEXT_IDS => '0001',
          ITEM_TEXT_IDS => '0001',
          CM => 'T',
          PR => 'P'
        },
        PROCESS_TYPE => @params[:create] ? 'CREATION' : 'SIMULATION',

        ITEMS_IN => @object.items.each_with_index.map do |item, index|
          {
            ITEM_NR => (100_001 + index).to_s,
            MAT => item.material,
            QTY => item.quantity,
            RDD => item.rdd,
            REFERENCE => '',
            REF_DOC_NR => '',
            REF_DOC_CAT => '',
            REF_ITEM_NR => '',
            EXT_ITEM_NR => (100_001 + index).to_s,
            UNIT => ''
          }
        end,

        PARTNERS_IN => @object.partners.map do |partner|
          {
            ITEM_NR => '000000',
            FCT => partner.function,
            NR => partner.number.add_leading_zeros
          }
        end,
        PRICE_COMPONENTS_IN => []
      }
    end

    def output
      super

      output_tables = %i[header header_in process_type cond_types drop_ship_addr items price_components
                         schedule_lines selling_units]
      @data = Struct.new(*output_tables).new(*output_tables.map { |table| get_function_param(table.to_s.upcase) })
    end
  end
end
