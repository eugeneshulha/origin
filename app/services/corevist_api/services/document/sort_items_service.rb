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

        result(items)
      end

      def sort_items(items)
        return items if @params[:sort_by].blank?

        items.sort_by do |item|
          item.send(@params[:sort_by]) if item.respond_to?(@params[:sort_by])
        end
      end

      def filter_by_query(items)
        return items if @params[:q].blank?

        items.select do |item|
          item.description.downcase.include?(@params[:q]) || item.material.downcase.include?(@params[:q])
        end
      end

      def obj
        eval(@form.class.to_s[/.+::.+::(.+)::/, 1]).new
      end
    end
  end
end
