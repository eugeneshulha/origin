module CorevistAPI::Services::Salesdocs
  class IndexService < CorevistAPI::Services::BaseServiceWithForm

    private

    def perform
      if @params[:doc_number]
        @rfc_result = service_for(:salesdocs_show, @form, @params).call

        result = @rfc_result.data
      else
        @rfc_result = rfc_service_for(:salesdoc_list, @form, @params).call

        salesdocs = @rfc_result.data.inject([]) do |memo, doc|
          salesdoc = builder_for(:basic_salesdoc, doc).build do |builder|
            builder.with_header
            builder.with_item_data
          end

          memo << salesdoc
        end

        array = filter_by_query(salesdocs)
        array = sort_by_param(array)

        result = paginate(items: array.map { |x| x.as_json(:short) })
      end

      result(result)
    end
  end
end
