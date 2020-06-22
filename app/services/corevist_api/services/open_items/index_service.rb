module CorevistAPI::Services::OpenItems
  class IndexService < CorevistAPI::Services::BaseServiceWithForm

    private

    def perform
      @rfc_result = rfc_service_for(:open_items, @form, @params).call

      open_items = @rfc_result.data[:open_items].flatten
      open_items = open_items.select { |open_item| @params[:items].include?(open_item.inv) } if @params[:items].present?
      array = sort_by_param(
        filter_by_query(open_items)
      )

      result(paginate(items: array))
    end
  end
end
