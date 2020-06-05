module CorevistAPI::Services::Admin::SystemSettings::SalesAreas
  class Step3Service < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      sales_area = CorevistAPI::SalesArea.find_by(id: @form&.uuid)
      raise CorevistAPI::ServiceException.new(not_found_msg) unless sales_area

      doc_categories = @form.doc_category_ids.each_with_object([]) do |doc_category_id, memo|
        doc_category = CorevistAPI::DocCategory.find_by(id: doc_category_id)
        raise CorevistAPI::ServiceException.new("error|attributes.#{namespace}.doc_category.not_found") unless doc_category

        memo << doc_category
      end

      sales_area.doc_categories = doc_categories

      result(sales_area)
    end
  end
end
