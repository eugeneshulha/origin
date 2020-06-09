module CorevistAPI::Services::Document
  class OutputTypesList < CorevistAPI::Services::BaseServiceWithForm

    private

    def perform
      @rfc_result = rfc_service_for(obj.api_names[:display], @object, @params).call

      document = builder_for(obj.model_name.element, @rfc_result.data).build(&:with_configs)

      data = document.config.output_types.map do |x|
        a = x.split('=')
        "#{doc_name}/#{document.doc_number}/output_types/#{a[1]}"
      end

      result({ output_types: data })
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
