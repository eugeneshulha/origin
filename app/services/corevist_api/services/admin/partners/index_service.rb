module CorevistAPI
  module Services
    module Admin::Partners
      class IndexService < CorevistAPI::Services::BaseServiceWithForm
        def perform
          rfc_result = rfc_service_for(:partner_search, @form, @params).call

          items = filter_by_query(rfc_result.data[:partners])
          items = sort_by_param(items)

          data = paginate(items: items)
          result(data)
        end
      end
    end
  end
end
