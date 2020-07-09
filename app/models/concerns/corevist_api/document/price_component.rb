module CorevistAPI
  module Document::PriceComponent
    extend ActiveSupport::Concern
    include CorevistAPI::FormatConversion

    included do
      attr_accessor :item_number, :cond_type, :value, :rate, :per, :unit, :calc_type, :currency

      format_amount :value, :rate
    end
  end
end
