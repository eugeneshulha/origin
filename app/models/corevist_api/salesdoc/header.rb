module CorevistAPI
  class Salesdoc
    class Header
      include CorevistAPI::FormatConversion

      attr_accessor :doc_date, :rdd,:inco_terms1, :inco_terms2, :ship_status, :credit_status, :po_type, :change_number,
                    :change_date, :contact_info, :invoice_number, :proforma_invoice_number, :total_value,
                    :valid_from, :valid_to, :ref_doc_number, :no_cwref_reason,  :no_copy_reason, :no_change_reason,

                    # array to parse
                    :price_components

      format_date :doc_date, :rdd, :change_date, :valid_from, :valid_to
      format_amount :total_value
    end
  end
end
