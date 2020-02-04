module CorevistAPI
  class RFCServices::SalesdocDisplayRFC < CorevistAPI::RFCServices::BaseRFC
    def initialize(*)
      super
    end

    private

    def input
      rfc_object = object_to_rfc
      rfc_user = user_to_rfc(@object.user)
      set_params(rfc_object.merge(rfc_user))
    end

    def object_to_rfc
      { DOC_NR => @oarams[:doc_nr] }
    end

    def output
      super

      get_function_param(SALES_DOCUMENTS).each do |doc|
        document = Salesdocs::SalesDocument.new
        set_salesdoc(document, doc)
        @data[:sales_documents] << document
      end

      set_salesdocs_order
      get_function_param(SHIPMENTS).each do |row|
        shipment = Salesdocs::Shipment.new
        set_shipment(shipment, row)
        @data[:shipments] << shipment
      end

      doc_ref = @data[:sales_documents].any? { |doc| doc.reference.present? }
      ship_ref = @data[:shipments].any? { |ship| ship.reference.present? }

      if doc_ref || ship_ref
        @data[:has_item_references] = true
      end

      @data[:item_list] = get_function_param(ITEM_LIST)
    end
  end
end
