module CorevistAPI
  module Document::Header
    extend ActiveSupport::Concern

    included do
      attr_accessor :doc_number, :doc_type,  :doc_category, :sales_area, :po_number, :payment_terms, :payment_terms_text,
                    :net_value, :currency,
                    # array to parse
                    :texts
    end
  end
end
