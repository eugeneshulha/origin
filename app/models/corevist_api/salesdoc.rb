require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/item.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/shipping_line.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/header.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/tracking_number.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/delivery.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/salesdoc/item_data.rb')

module CorevistAPI
  class Salesdoc
    include CorevistAPI::Document
    include CorevistAPI::FormatConversion

    # TODO: move to concerns/corevist_api/document.rb if relevant for any other document type
    attr_accessor :deliveries, :item_data

    delegate  :doc_date, :rdd, :inco_terms1, :inco_terms2, :ship_status, :credit_status, :po_type, :change_number,
              :change_date, :contact_info, :invoice_number, :proforma_invoice_number, :total_value,
              :valid_from, :valid_to, :ref_doc_number, :no_cwref_reason,  :no_copy_reason, :no_change_reason,
              :doc_number, :doc_type,  :doc_category, :sales_area, :po_number, :payment_terms, :payment_terms_text,
              :net_value, :currency, to: :header


    delegate :sold_to_description, :sold_to_number, :material, :output_types, :delivery_number, :item_number,
             :quantity, :sales_uom, :ship_to_description, :ship_to_number, :to_date, :from_date, :reference, to: :item_data

    def initialize
      super
      @deliveries = []
      @item_data = CorevistAPI::Salesdoc::ItemData.new
    end

    def as_json(mode = :short)
      return super unless mode == :short

      {
          credit_status: self.credit_status,
          currency: self.currency,
          doc_category: self.doc_category,
          doc_date: self.doc_date,
          doc_number: self.doc_number.drop_leading_zeros,
          doc_type: self.doc_type,
          net_value: self.net_value,
          po_number: self.po_number,
          invoice_number: self.invoice_number.drop_leading_zeros,
          ship_status: self.ship_status,
          valid_from: self.valid_from,
          valid_to: self.valid_to,
          rdd: self.rdd,
          sales_area: self.sales_area,

          sold_to_description: self.sold_to_description,
          sold_to_number: self.sold_to_number,
          material: self.material,
          output_types: self.output_types,
          delivery_number: self.delivery_number.drop_leading_zeros,
          quantity: self.quantity,
          sales_uom: self.sales_uom,
          ship_to_description: self.ship_to_description,
          ship_to_number: self.ship_to_number.drop_leading_zeros,
          to_date: self.to_date,
          from_date: self.from_date
      }
    end
  end
end
