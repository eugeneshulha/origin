module CorevistAPI
  module Builders
    class PaymentBuilder < CorevistAPI::Builders::BaseBuilder
      def build
        yield(self)
        @object
      end

      def with_base_params
        sap_field_mapper_for(:payment, :payment).each { |k,v| @object.send("#{v}=", @params[:payment].send(k)) }
      end

      def with_items
        return unless @object.payment_number
        items_data = @params[:items]&.select {|item| item.pay_doc_no == @object.payment_number }

        item = CorevistAPI::Payment::Item.new
        items_data.inject(@object.items) do |memo, data|
          sap_field_mapper_for(:payment, :item).each { |k,v| item.send("#{v}=", data.send(k)) }
          memo << item
        end
      end

      private

      def obtain_object
        CorevistAPI::Payment.new
      end
    end
  end
end
