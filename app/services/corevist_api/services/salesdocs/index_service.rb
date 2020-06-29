module CorevistAPI::Services::Salesdocs
  class IndexService < CorevistAPI::Services::BaseServiceWithForm

    private

    def perform
      if @params[:doc_number]
        @rfc_result = service_for(:salesdocs_show, @form, @params).call

        result = @rfc_result.data
      else
        @rfc_result = rfc_service_for(:salesdoc_list, @form, @params).call

        array = filter_by_query(@rfc_result.data)
        array = sort_by_param(array)

        result = paginate(items: array)
      end

      result(result)
    end
  end
end
