module CorevistAPI
  module Sortable
    extend ActiveSupport::Concern

    included do
      @sort_as = Hash.new(:text)

      class << self

        %i[numeric date].each do |type|
          define_method :"sort_as_#{type}" do |*fields|
            fields.each do |field|
              @sort_as[field] = type
            end
          end
        end

        def sort_as
          @sort_as
        end
      end

      def sort_type(field)
        self.class.sort_as[field]
      end
    end
  end
end