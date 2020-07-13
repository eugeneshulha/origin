module CorevistAPI
  module Builders
    class BasicSalesdocBuilder < CorevistAPI::Builders::BaseBuilder
      def with_header
        sap_field_mapper_for(:salesdoc, :header).each { |k,v| @object.header.send("#{v}=", @params.instance_variable_get(:"@#{k}")) }
      end

      def with_item_data
        sap_field_mapper_for(:salesdoc, :item_data).each { |k,v| @object.item_data.send("#{v}=", @params.instance_variable_get(:"@#{k}")) }
      end

      private

      def obtain_object
        doc = CorevistAPI::Salesdoc.new
        doc.doc_number = @params.doc_nr
        raise CorevistAPI::ServiceException.new("api.salesdoc.doc_nr_not_found") unless doc.doc_number

        doc
      end
    end
  end
end
