module CorevistAPI
  module Services::AccountDetails
    class Show < CorevistAPI::Services::BaseServiceWithForm

      def perform
        user = CorevistAPI::User.find_by_id(@params[:user_id])

        open_items = user.payers&.inject([]) do |memo, payer|
          payer = Struct.new(:payer_number).new(payer.number)

          rfc_result = rfc_service_for(:open_items, payer, @params).call
          memo << rfc_result.data[:open_items]
          memo
        end&.flatten

        balance = []
        balance << open_items.select { |item| item.due_date.to_date < Time.zone.now.to_date }.each_with_index.inject({}) do |memo, (item, index)|
          memo[:status] ||= 'Overdue'
          memo[:amount].present? ? memo[:amount].to_f + item.due_today.to_f : memo[:amount] = item.due_today.to_f
          memo[:count] = index
          memo
        end

        balance << open_items.each_with_index.inject({}) do |memo, (item, index)|
          memo[:status] ||= 'Outstanding'
          memo[:amount].present? ? memo[:amount].to_f + item.due_today.to_f : memo[:amount] = item.due_today.to_f
          memo[:count] = index
          memo
        end

        {
            # credit: {
            #   limit: open_items.accounting_data.credit_limit).tr('$&nbsp;', ''),
            #   remaining:  open_items.accounting_data.remaining_credit).tr('$&nbsp;', '') }
        }

        result(balance: balance)
      end
    end
  end
end
