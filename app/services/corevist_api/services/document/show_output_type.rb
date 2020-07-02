module CorevistAPI::Services::Document
  class ShowOutputType < CorevistAPI::Services::BaseServiceWithForm

    private

    def perform
      @rfc_result = rfc_service_for("#{obj.model_name.element}_display", @object, @params).call
      document = builder_for(obj.model_name.element, @rfc_result.data).build(&:with_header)

      @rfc_result = rfc_service_for(:get_pdf, document, @params).call

      result(@rfc_result.data[:pdf])
    end

    def doc_name
      @params[:controller]
        .gsub('corevist_api/api/v1/', '')
        .gsub('/output_types', '')
    end

    def obj
      @params[:controller]
        .gsub('/api/v1/', '::_')
        .gsub('/output_types', '')
        .singularize
        .camelize
        .constantize
        .new
    end
  end
end
