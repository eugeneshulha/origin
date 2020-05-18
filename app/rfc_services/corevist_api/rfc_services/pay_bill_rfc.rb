module CorevistAPI
  class RFCServices::PayBillRFC < CorevistAPI::RFCServices::BaseRFCService
    P_FUNCTION = { c: :credit_card_to_rfc, e: :echeck_to_rfc }.freeze
    MSG_UNSUPPORTED_METHOD = 'api.errors.open_items.unsupported_method'.freeze

    def function_name
      :pay_bill
    end

    def input
      rfc_object = object_to_rfc
      rfc_user = user_to_rfc(user)
      set_params(rfc_object.merge(rfc_user))
    end

    def object_to_rfc
      hash = { PAYMENT_HEADER => payment_header_to_rfc }
      p_hash = public_send(payment_method)
      hash.merge!(p_hash)
      hash.merge!(items_to_rfc)
    end

    def credit_card_to_rfc
      {
        CREDIT_CARD_IN => {
          CARD_TYPE => @object.credit_card[:cc_type],
          CARD_NR => @object.credit_card[:cc_number],
          VALID_TO => @object.credit_card[:cc_exp_date],
          NAME_ON_CARD => @object.credit_card[:cc_name],
          CURR => @object.currency,
          AUTH_AMOUNT => @object.amount.to_s,
          AUTH_DATE => @object.credit_card[:auth_date],
          AUTH_TIME => @object.credit_card[:auth_time],
          AUTH_NR => @object.credit_card[:auth_number],
          AUTH_REF_NR => @object.credit_card[:auth_ref_number],
          GL_ACCOUNT => Settings.dig(:spreedly, :gl_account),
          MERCHANT => Settings.dig(:spreedly, :merchant),
          REACTION => Settings.dig(:spreedly, :reaction),
          TEXT => @object.credit_card[:text]
        }
      }
    end

    def echeck_to_rfc
      { ECHECK => {} }
    end

    def payment_header_to_rfc
      today = Time.zone.today.date_to_rfc_str
      {
        REF_DOC_NO => @params[:reference_number],
        HEADER_TXT => @object.credit_card[:header_text],
        ITEM_TEXT => Settings.dig(:spreedly, :item_text),
        ACCT_PROCEDURE => Settings.dig(:spreedly, :account_procedure),
        CLEARING_TEXT => Settings.dig(:spreedly, :clearing_text),
        CLEARING_TRAN => Settings.dig(:spreedly, :clearing_tran),
        BDCMODE => Settings.dig(:spreedly, :bdc_mode),
        PROFIT_CTR => Settings.dig(:spreedly, :profit_center),
        DOC_TYPE => Settings.dig(:spreedly, :doc_type),
        DOC_DATE => today,
        PSTNG_DATE => today,
        CURR => @object.currency,
        VALID_ON => @object.valid_on,
        RFC_FLAGS => Settings.dig(:spreedly, :rfc_flags),
        COMP_CODE => @object.comp_code,
        PAYER_NR => @object.payer_number
      }
    end

    def items_to_rfc
      items = @object.invoices.each_with_object([]) do |item, memo|
        memo << {
          INV => item.inv,
          AC_DOC_NO => item.fi_nr,
          FISC_YEAR => item.fiscal_year,
          ITEM_NUM => item.item_num,
          PAY_AMNT => item.due_today
        }
      end

      { PAY_ITEMS_IN => items }
    end

    def output
      super

      @data = Struct.new(:payment_doc_number).new(get_function_param(PAYMENT_DOC_NO))
    end

    private

    def payment_method
      method = P_FUNCTION[@params[:payment_method].downcase.to_sym]
      raise CorevistAPI::ServiceException.new(MSG_UNSUPPORTED_METHOD) unless method && respond_to?(method)

      method
    end
  end
end
