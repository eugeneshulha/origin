module CorevistAPI
  module Services
    module Admin::Partners
      class IndexService< CorevistAPI::Services::BaseServiceWithForm
        def perform
          rfc_result = rfc_service_for(:partner_search, @form, @params).call

          data = paginate(items: rfc_result.data[:partners])
          result(data)
        end
      end
    end
  end
end
