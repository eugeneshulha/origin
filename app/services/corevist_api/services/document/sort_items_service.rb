module CorevistAPI
  module Services::Document
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
        items = sort_items(items)

        hash = paginate(items)

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

      def paginate(_items)
        p_size = @params[:page_size].present? ? @params[:page_size].to_i : DEFAULT_PAGE_SIZE
        p_size = p_size < 1 ? 1 : p_size

        p_number = @params[:page].present? ? @params[:page].to_i : 1
        p_number = 0 if p_number <= 1
        p_number = p_number - 1 if p_number > 1

        p_count = _items.size / p_size + 1
        total_size = _items.size

        items = _items.drop(p_size * p_number).first(p_size)

        {
            pagination: {
                totalResults: total_size,
                pageCount: p_count,
                pageNumber: p_number + 1,
                pageSize: p_size,
            },
            items: items.as_json
        }
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
