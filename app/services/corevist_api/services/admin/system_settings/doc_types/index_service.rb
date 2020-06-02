module CorevistAPI::Services::Admin::SystemSettings::DocTypes
  class IndexService < CorevistAPI::Services::Base::IndexService
    def perform
      data = if @params[:sales_area_id].present?
               sales_area = CorevistAPI::SalesArea.find_by(id: @params[:sales_area_id])

               raise CorevistAPI::ServiceException.new(not_found_msg) unless sales_area.present?

               items = sort_by_param(filter_by_query(sales_area.doc_types_list))
               paginate(items: items).merge(sales_area_title: sales_area.title)
             else
               items = sort_by_param(filter_by_query(CorevistAPI::DocType.all))
               paginate(items: items)
             end

      result(data)
    end
  end
end
