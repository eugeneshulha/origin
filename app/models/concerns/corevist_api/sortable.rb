module CorevistAPI
  module Sortable
    extend ActiveSupport::Concern

    included do
      @sort_as = Hash.new(:text)

      class << self

        %i[number date].each do |type|
          define_method :"sort_as_#{type}" do |*fields|
            fields.each do |field|
              @sort_as[field] = type
            end
          end
        end

        attr_reader :sort_as
      end

      def sort_type(field)
        self.class.sort_as[field]
      end
    end
  end
end
