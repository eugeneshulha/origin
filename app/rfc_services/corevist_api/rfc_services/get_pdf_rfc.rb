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
      { GET_PDF_IN => {
          PRINTER_ID => 'LP01',
          METHOD => 'pdf',
          LANG => 'E',
          DOC_CAT => @object.header.doc_category,
          DOC_NR => @object.doc_number.add_leading_zeros,
          OUTPUT_TYPE => @params[:output_type_id].to_s.strip
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
