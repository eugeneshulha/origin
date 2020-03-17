module CorevistAPI
  module Services::Invoice
    class SortItemsService < CorevistAPI::Services::BaseServiceWithForm

      private

      def perform
        rfc_result = rfc_service_for(:invoice_display, @form, @params).call
        items = rfc_result.data['items']
        result(filter_by_query(items))
      end

      def filter_by_query(items)
        return items if @params[:q].blank?

        items.select do |item|
          item.descr.downcase.include?(@params[:q]) || item.mat.downcase.include?(@params[:q])
        end
      end
    end
  end
end
