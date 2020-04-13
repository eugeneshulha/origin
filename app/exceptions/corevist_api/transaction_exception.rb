module CorevistAPI
  class TransactionException < StandardError
    attr_reader :transaction

    def initialize(message = nil)
      message ||= 'Transaction failed'
      Rails.logger.error(message)

      super("We're sorry but your payment transaction failed. Reason: #{message}")
    end
  end
end
