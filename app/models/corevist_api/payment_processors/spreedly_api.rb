module CorevistAPI
  module PaymentProcessors
    class SpreedlyAPI
      require 'spreedly'
      include Singleton

      # TODO: move to settings
      SPREEDLY_ENV_KEY = "ED7WwP1r22srNCZF66BYca00fQP".freeze
      SPREEDLY_ACCESS_KEY = "qot46AtVxc4tZ4Ip0zD3p95tOG31w26ywijvvRrj57wwzxAqwfra4RFZ1fj4NdZR".freeze
      CC_TYPES_MAPPING = {
          visa: 'VISA',
          master: 'MC',
          american_express: 'AMEX'
      }.freeze

      attr_reader :env, :gateway

      def initialize(gateway_token = nil)
        @env = Spreedly::Environment.new(SPREEDLY_ENV_KEY, SPREEDLY_ACCESS_KEY)

        @gateway = if gateway_token
          @env.find_gateway(gateway_token)
        else
          @env.add_gateway(:test)
        end
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
        @env.authorize_on_gateway(@gateway.token, obj.token, obj.amount,
                                 order_id: obj.reference_number,
                                 currency_code: obj.currency
        )
      rescue Exception => e
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
          hash[:cc_type] = CC_TYPES_MAPPING[payment_method.card_type.to_sym]
          hash[:cc_number] = payment_method.number
          hash[:cc_name] = payment_method.full_name
          hash[:cc_exp_date] = Date.new(payment_method.year.to_i, payment_method.month.to_i, -1).strftime('%Y%m%d')
          hash[:cc_last_4] = payment_method.last_four_digits
        end

        response
      end

      def verify(token)
        transaction = @env.verify_on_gateway(
            @gateway.token,
            token,
            retain_on_success: true
        )
        raise TransactionException.new(transaction.message) unless transaction.succeeded?
      end
    end
  end
end
