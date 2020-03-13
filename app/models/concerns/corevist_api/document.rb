module CorevistAPI
  module Document
    extend ActiveSupport::Concern
    include ActiveModel::Model

    included do
      attr_accessor :header, :items, :partners, :payment_terms, :config, :cond_types, :sap_return, :price_components
                    :user_id

      class self::Header
        include CorevistAPI::Document::Header
      end

      class self::Item
        include CorevistAPI::Document::Item
      end

      class self::Config
        include CorevistAPI::Document::Config
      end

      class self::PaymentTerms
        include CorevistAPI::Document::PaymentTerms
      end

      class self::PriceComponent
        include CorevistAPI::Document::PriceComponent
      end

      def initialize
        @items = []
        @partners = []
        @price_components = []
        @config = "#{self.class}::Config".constantize.new
        @header = "#{self.class}::Header".constantize.new
      end

      def doc_number
        @header.doc_number
      end

      def doc_number=(doc_number)
        @header.doc_number = doc_number
      end

      def user
        CorevistAPI::User.find_by(user_id: self.user_id)
      end

      def api_names
        name = self.model_name.element
        {
            display: "#{name}_display",
            list: "#{name}_list",
            sort_items: "sort_#{name}_items"
        }
      end
    end
  end
end
