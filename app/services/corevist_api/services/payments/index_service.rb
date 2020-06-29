module CorevistAPI::Services::Payments
  class IndexService < CorevistAPI::Services::BaseServiceWithForm

    private

    def perform
      @rfc_result = rfc_service_for(:payments_list, @form, @params).call

      payments = @rfc_result.data[:payments]&.inject([]) do |memo, payment_data|
        data = { payment: payment_data, items: @rfc_result.data[:items] }

        payment = builder_for(:payment, data).build do |builder|
          builder.with_base_params
          builder.with_items
        end
        memo << payment
      end

      array = filter_by_query(payments)
      array = sort_by_param(array)

      result = paginate(items: array)

      result(result)
    end
  end
end
