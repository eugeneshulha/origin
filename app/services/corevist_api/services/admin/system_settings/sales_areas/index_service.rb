module CorevistAPI::Services::Admin::SystemSettings::SalesAreas
  class IndexService < CorevistAPI::Services::Base::IndexService
    def perform
      data = if @params[:microsite_id].present?
               microsite = CorevistAPI::Microsite.find_by(id: @params[:microsite_id])

               raise CorevistAPI::ServiceException.new(not_found_msg) unless microsite.present?

               items = sort_by_param(filter_by_query(microsite.sales_areas_list))
               paginate(items: items).merge(microsite_title: microsite.name)
             else
               items = sort_by_param(filter_by_query(CorevistAPI::SalesArea.all))
               paginate(items: items)
             end

      result(data)
    end
  end
end
