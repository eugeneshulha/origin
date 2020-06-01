module CorevistAPI::Services::Admin::Permissions
  class IndexService < CorevistAPI::Services::Base::IndexService
    def perform
      data = if @params[:role_id].present?
               role = CorevistAPI::Role.find_by(id: @params[:role_id])

               raise CorevistAPI::ServiceException.new(not_found_msg) unless role.present?

               items = sort_by_param(filter_by_query(role.permissions_list))
               paginate(items: items).merge(role_title: role.title)
             else
               items = sort_by_param(filter_by_query(CorevistAPI::Permission.all))
               paginate(items: items)
             end

      result(data)
    end
  end
end
