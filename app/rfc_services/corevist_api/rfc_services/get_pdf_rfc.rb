module CorevistAPI
  class RFCServices::GetPdfRFC < CorevistAPI::RFCServices::BaseRFCService
    private

    def function_name
      :get_pdf
    end

    def input
      rfc_object = object_to_rfc
      set_params(rfc_object)
    end

    def object_to_rfc
      output_type = @params[:output_type_id].to_s.strip
      {
        GET_PDF_IN => {
          PRINTER_ID => Settings.dig(:sap, :output_types, output_type, :printer_id).to_s,
          METHOD => Settings.dig(:sap, :output_types, output_type, :special_method).to_s,
          LANG => 'E',
          DOC_CAT => @object.header.doc_category.to_s,
          DOC_NR => @object.doc_number.add_leading_zeros,
          OUTPUT_TYPE => output_type
        }
      }
    end

    def output
      super

      pdf = ''.tap do |string|
        @function.PDF_TAB.each { |x| string << x['LINE'] }
      end

      @data[:pdf] = pdf
    end
  end
end
