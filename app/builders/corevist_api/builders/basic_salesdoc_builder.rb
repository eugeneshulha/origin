module CorevistAPI
  module Builders
    class BasicSalesdocBuilder < CorevistAPI::Builders::BaseBuilder
      MAX_ADDRESSES_COUNT = 3

      def with_header
        sap_field_mapper_for(:salesdoc, :header).each { |k,v| @object.header.send("#{v}=", @params.instance_variable_get(:"@#{k}")) }
      end

      def with_additional_data
        sap_field_mapper_for(:salesdoc, :data_from_search).each { |k,v| @object.send("#{v}=", @params.instance_variable_get(:"@#{k}")) }
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
