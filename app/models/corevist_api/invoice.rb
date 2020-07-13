require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/invoice/item.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/invoice/payment_history.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/invoice/header.rb')
require File.join(CorevistAPI::Engine.root, 'app/models/corevist_api/invoice/item_data.rb')


module CorevistAPI
  class Invoice
    include CorevistAPI::Document

    attr_accessor :item_data
    delegate :item_number, :material, :quantity, :sales_uom, :cond_uom, :payer_number, :payer_description, to: :item_data

    delegate :billing_date, :tax, :status, :due_date, :company_code, :doc_number, :doc_type, :doc_category, :sales_area,
             :currency, :net_value, :payment_terms, :payment_terms_text, :sales_order, :payment_status,
             :due_status, to: :header


    def initialize
      super
      @item_data = CorevistAPI::Invoice::ItemData.new
    end

    def as_json(mode = :short)
      return super unless mode == :short

      {
          billing_date: self.billing_date,
          tax: self.tax,
          status: self.status,
          due_date: self.due_date,
          company_code: self.company_code,
          doc_number: self.doc_number,
          doc_type: self.doc_type,
          doc_category: self.doc_category,
          sales_area: self.sales_area,
          currency: self.currency,
          net_value: self.net_value,
          payment_terms: self.payment_terms,
          payment_terms_text: self.payment_terms_text,
          sales_order: self.sales_order,
          payment_status: self.payment_status,
          due_status: self.due_status,
          po_number: self.po_number,

          item_number: self.item_number,
          material: self.material,
          quantity: self.quantity,
          sales_uom: self.sales_uom,
          cond_uom: self.cond_uom,
          payer_number: self.payer_number,
          payer_description: self.payer_description
      }
    end
  end
end
