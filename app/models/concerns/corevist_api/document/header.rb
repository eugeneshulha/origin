module CorevistAPI
  module Document::Header
    extend ActiveSupport::Concern
    include CorevistAPI::FormatConversion

    included do
      attr_accessor :doc_number, :doc_type,  :doc_category, :sales_area, :po_number, :payment_terms, :payment_terms_text,
                    :net_value, :currency,
                    # array to parse
                    :texts

      format_number :net_value
    end
  end
end
