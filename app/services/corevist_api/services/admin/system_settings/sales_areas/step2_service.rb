module CorevistAPI::Services::Admin::SystemSettings::SalesAreas
  class Step2Service < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      sales_area = CorevistAPI::SalesArea.find_by(id: @form&.uuid)
      raise CorevistAPI::ServiceException.new(not_found_msg) unless sales_area

      doc_types = @form.doc_type_ids.each_with_object([]) do |doc_type_id, memo|
        doc_type = CorevistAPI::DocType.find_by(id: doc_type_id)
        raise CorevistAPI::ServiceException.new("error|attributes.#{namespace}.doc_type.not_found") unless doc_type

        memo << doc_type
      end

      sales_area.doc_types = doc_types

      result(sales_area)
    end
  end
end
