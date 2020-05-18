module CorevistAPI
  module PaymentProcessors
    class SpreedlyAPI
      require 'spreedly'
      include Singleton

      attr_reader :env, :gateway

      def initialize(gateway_token = nil)
        @env = Spreedly::Environment.new(config(:env_key), config(:access_key))

        @gateway = gateway_token ? @env.find_gateway(gateway_token) : @env.add_gateway(:test)
      end

      def authorize_amount(obj)
        verify(obj.token)
        obj.credit_card = get_cc_details(obj.token)

        auth_transaction = authorize!(obj)
        raise TransactionException unless auth_transaction&.succeeded?

        obj.auth_token = auth_transaction.token
      end

      def capture_amount(auth_token)
        capture_transaction = @env.capture_transaction(auth_token)
        raise TransactionException, 'capture transaction failed' unless capture_transaction&.succeeded?
      end

      private

      def authorize!(obj)
        transaction = @env.authorize_on_gateway(
          @gateway.token,
          obj.token,
          obj.amount,
          order_id: obj.reference_number,
          currency_code: obj.currency
        )
        fill_cc_data(transaction, obj) if transaction&.succeeded?
        transaction
      rescue StandardError => e
        raise TransactionException.new(e.message)
      end

      def get_cc_details(token)
        response = {
          token: token,
          cc_type: nil,
          cc_number: nil,
          cc_name: nil,
          cc_exp_date: nil,
          cc_last_4: nil
        }

        payment_method = @env.find_payment_method(token)

        response.tap do |hash|
          hash[:cc_type] = config(:cc_types, payment_method.card_type)
          hash[:cc_number] = payment_method.number
          hash[:cc_name] = payment_method.full_name
          hash[:cc_exp_date] = Date.new(payment_method.year.to_i, payment_method.month.to_i, -1).strftime('%Y%m%d')
          hash[:cc_last_4] = payment_method.last_four_digits
        end

        response
      end

      def verify(token)
        transaction = @env.verify_on_gateway(@gateway.token, token, retain_on_success: true)
        raise TransactionException.new(transaction.message) unless transaction.succeeded?
      end

      def config(*keys)
        Settings.dig(:spreedly, *keys)
      end

      def fill_cc_data(transaction, object)
        object.credit_card[:auth_date] = transaction.created_at.strftime('%Y%m%d')
        object.credit_card[:auth_time] = transaction.created_at.strftime('%H%M%S')
        object.credit_card[:auth_ref_number] = object.credit_card[:auth_number] = transaction.gateway_transaction_id
        object.credit_card[:text] = "#{transaction.gateway_token} - #{transaction.gateway_transaction_id}"
        object.credit_card[:header_text] = transaction.gateway_transaction_id
      end
    end
  end
end
