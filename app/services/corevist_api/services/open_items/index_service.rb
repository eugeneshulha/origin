module CorevistAPI::Services::OpenItems
  class IndexService < CorevistAPI::Services::BaseServiceWithForm

    private

    def perform
      @rfc_result = rfc_service_for(:open_items, @form, @params).call

      open_items = @rfc_result.data[:open_items].flatten

      objects = open_items.inject([]) do |memo, _open_item|
        open_item = builder_for(:open_item, _open_item).build(&:with_base_params)
        memo << open_item
      end

      objects = objects.select { |open_item| @params[:items].include?(open_item.invoice_number.drop_leading_zeros) } if @params[:items].present?
      array = sort_by_param(
        filter_by_query(objects)
      )

      result(paginate(items: array))
    end
  end
end
