module CorevistAPI
  class API::V1::PaymentsController < API::V1::BaseController
    configs_for :new

    PAYMENT_METHODS_MAP = {
        c: :credit_card,
        i: :invoice,
        p: :pay_pal,
        d: :delego,
        e: :echeck
    }.freeze

    private

    def performer_name
      m = PAYMENT_METHODS_MAP[params[:payment_method].to_sym]
      raise StandardError.new(_('error|attributes.payment_method.blank')) unless m

      "#{action_prefix}_#{action_name}_#{m}".to_sym
    end
  end
end
