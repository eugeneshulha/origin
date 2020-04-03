module CorevistAPI
  module Services::AccountDetails
    class Show < CorevistAPI::Services::BaseServiceWithForm

      def perform
        result = { }

        payer = Struct.new(:payer_number).new(params[:payer])
        rfc_result = rfc_service_for(:open_items, payer, @params).call

        result[:open_items] = rfc_result.data[:open_items]
        result[:accounting_data] = rfc_result.data[:accounting_data]

        balance = []
        balance << result[:open_items].select { |item| item.due_date.to_date < Time.zone.now.to_date }.each_with_index.inject({}) do |memo, (item, index)|
          memo[:status] ||= 'Overdue'
          memo[:amount].present? ? memo[:amount].to_f + item.due_today.to_f : memo[:amount] = item.due_today.to_f
          memo[:count] = index
          memo
        end

        balance << result[:open_items].each_with_index.inject({}) do |memo, (item, index)|
          memo[:status] ||= 'Outstanding'
          memo[:amount].present? ? memo[:amount].to_f + item.due_today.to_f : memo[:amount] = item.due_today.to_f
          memo[:count] = index
          memo
        end

        limit = result[:accounting_data].inject(0) do |memo, x|
          memo += x.credit_limit.to_f
        end

        remaining = result[:accounting_data].inject(0) { |memo, x| memo += x.rem_credit.to_f }

        data = {
            balance: balance,
            credit: {
              limit: limit,
              remaining:  remaining
            }
        }

        result(data)
      end
    end
  end
end
