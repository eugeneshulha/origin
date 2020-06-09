module CorevistAPI::Services::Document
  class SortItemsService < CorevistAPI::Services::BaseServiceWithForm

    private

    def perform
      @rfc_result = rfc_service_for(obj.api_names[:display], @object, @params).call

      document = builder_for(obj.model_name.element, @rfc_result.data).build do |builder|
        builder.with_configs
        builder.with_items
        builder.with_header
        builder.with_partners
      end

      items = filter_by_query(document.items)
      items = sort_by_param(items)

      hash = paginate(items: items)

      result(hash)
    end

    def obj
      @params[:controller]
        .gsub('/api/v1/', '::_')
        .gsub('/items', '')
        .singularize
        .camelize
        .constantize
        .new
    end
  end
end
