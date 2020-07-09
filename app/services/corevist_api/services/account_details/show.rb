module CorevistAPI::Services::AccountDetails
  class Show < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      result = { }

      payer = Struct.new(:payer_number).new(@params[:payer])
      rfc_result = rfc_service_for(:open_items, payer, @params).call

      result[:open_items] = rfc_result.data[:open_items]
      result[:accounting_data] = rfc_result.data[:accounting_data]

      balance = []
      balance << result[:open_items].select { |item| item.due_date.to_date < Time.zone.now.to_date }.each_with_index.inject({}) do |memo, (item, index)|
        memo[:status] ||= _('lbl|overdue')
        memo[:amount] = memo[:amount].present? ? memo[:amount].to_f + item.due_today.to_f : item.due_today.to_f
        memo[:count] = index
        memo
      end

      balance << result[:open_items].each_with_index.inject({}) do |memo, (item, index)|
        memo[:status] ||= _('lbl|outstanding')
        memo[:amount] = memo[:amount].present? ? memo[:amount].to_f + item.due_today.to_f : item.due_today.to_f
        memo[:count] = index
        memo
      end

      balance.each do |b|
        next unless b[:amount]
        b[:amount] = b[:amount].to_s&.to_amount_with_format(result[:accounting_data]&.cc_curr)
      end

      data = {
          balance: balance,
          credit: {
            limit: result[:accounting_data].credit_limit,
            remaining:   result[:accounting_data].rem_credit
          }
      }

      result(data)
    end
  end
end
