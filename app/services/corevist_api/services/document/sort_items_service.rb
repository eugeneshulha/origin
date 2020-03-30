module CorevistAPI
  module Services::Document
    class SortItemsService < CorevistAPI::Services::BaseServiceWithForm
      include CorevistAPI::Services::Paginatable

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
        items = sort_items(items)

        hash = paginate(items: items)

        result(hash)
      end

      def sort_items(items)
        return items if @params[:sort_by].blank?

        items = items.sort_by do |item|
          item.send(@params[:sort_by]) if item.respond_to?(@params[:sort_by])
        end

        items.reverse! if @params[:order]&.to_sym == :desc
        items
      end

      def filter_by_query(items)
        return items if @params[:q].blank?
        items.select do |item|
          item.description.downcase.include?(@params[:q].downcase) || item.material.downcase.include?(@params[:q].downcase)
        end
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
end