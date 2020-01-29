module CorevistAPI
  module Filters::Results
    class UserResult < BaseResult
      attr_accessor :partners, :partner_number

      def initialize(*args)
        super
        @partners = []
        @partner_number = nil
      end
    end
  end
end
