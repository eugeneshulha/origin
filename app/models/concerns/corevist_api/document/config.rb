module CorevistAPI
  module Document::Config
    extend ActiveSupport::Concern

    included do
      attr_accessor :partners, :header_texts, :item_texts, :output_types, :price_rule, :views
    end
  end
end
