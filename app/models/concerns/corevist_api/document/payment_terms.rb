module CorevistAPI
  module Document::PaymentTerms
    extend ActiveSupport::Concern

    included do
      attr_accessor :line
    end
  end
end
