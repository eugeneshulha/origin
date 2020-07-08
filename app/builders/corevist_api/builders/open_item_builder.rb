module CorevistAPI
  module Builders
    class OpenItemBuilder < CorevistAPI::Builders::BaseBuilder
      MAX_ADDRESSES_COUNT = 3

      def with_base_params
        sap_field_mapper_for(:open_item, :item).each { |k,v| @object.send("#{v}=", @params.send(k)) }
        with_boolean_conversions
        with_debit_or_credit
      end

      def with_debit_or_credit
        @object.debit = false if @params.dcind == 'H'
      end

      def with_boolean_conversions
        @object.partially_paid = @params.part_paid.sap_to_boolean
      end

      private

      def obtain_object
        CorevistAPI::OpenItem.new
      end
    end
  end
end
