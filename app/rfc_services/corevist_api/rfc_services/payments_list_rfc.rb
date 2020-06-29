module CorevistAPI
  class RFCServices::PaymentsListRFC < CorevistAPI::RFCServices::BaseRFCService
    def initialize(*)
      super
    end

    private

    def function_name
      :payments_list
    end

    def input
      rfc_object = object_to_rfc
      rfc_user = user_to_rfc(user)
      set_params(rfc_object.merge(rfc_user))
    end

    def object_to_rfc
      hash = {
          PAYMENT_SEARCH_CRITERIA => {
              RFC_FLAGS => '',
              ITEM_TEXT => '*',
              REF_DOC_NO => '*'
          }
      }

      hash[PAYMENT_SEARCH_CRITERIA].tap do |h|
        h[PAYER_NR]    = @object.value_for_key(:payer_number).add_leading_zeros if @object.value_for_key(:payer_number)
        h[FROM_DATE]   = @object.value_for_key(:from_date).to_s                 if @object.value_for_key(:from_date)
        h[TO_DATE]     = @object.value_for_key(:to_date).to_s                   if @object.value_for_key(:to_date)
        h[COMP_CODE]   = @object.value_for_key(:comp_code).to_s                 if @object.value_for_key(:comp_code)
        h[FROM_AMOUNT] = @object.value_for_key(:from_amount).add_leading_zeros  if @object.value_for_key(:from_amount)
        h[TO_AMOUNT]   = @object.value_for_key(:to_amount).add_leading_zeros    if @object.value_for_key(:to_amount)
      end
      hash
    end

    def output
      super

      @data[:payments] = get_function_param(PAYMENTS).map do |payment|
        RfcResultEntry.new(self.class.name.demodulize.underscore, payment)
      end

      @data[:company_codes] = RfcResultEntry.new(nil, get_function_param(COMP_CODES))

      @data[:es_payments_out] = get_function_param(ES_PAYMENTS_OUT).try(:[], 'COMP_CODE')

      @data[:items] = get_function_param(PAID_ITEMS).map do |item|
        RfcResultEntry.new(self.class.name.demodulize.underscore, item)
      end
    end
  end
end
