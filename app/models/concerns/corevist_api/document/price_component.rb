module CorevistAPI
  module Document::PriceComponent
    extend ActiveSupport::Concern

    included do
      attr_accessor :item_number, :cond_type, :value, :rate, :per, :unit, :calc_type, :runit
    end
  end
end
