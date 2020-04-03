module CorevistAPI
  class RFCServices::PayBillRFC < CorevistAPI::RFCServices::BaseRFCService
    P_FUNCTION = { c: :credit_card_to_rfc, e: :echeck_to_rfc }.freeze

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

      method = P_FUNCTION[@params[:payment_method].downcase.to_sym]
      p_hash = self.send(method)

      hash.merge!(p_hash)
      hash.merge!(items_to_rfc)
    end

    def credit_card_to_rfc
      hash = {
        CARD_TYPE => @params[:credit_card][:type],
        CARD_NR => @params[:credit_card][:number],
        VALID_TO => @params[:credit_card][:valid_to],
        NAME_ON_CARD => @params[:credit_card][:name],
        CURR => 'USD',
        AUTH_AMOUNT => '9689.00',
        AUTH_DATE => '20200402',
        AUTH_TIME => '154121',
        AUTH_NR => '',
        AUTH_REF_NR => '',
        GL_ACCOUNT => '0000113108',
        MERCHANT => 'BLT_INC_USD',
        REACTION => '',
        TEXT => ''
      }

      { CREDIT_CARD_IN => hash }
    end

    def echeck_to_rfc
      { ECHECK => {} }
    end

    def payment_header_to_rfc
      {
        REF_DOC_NO => @params[:reference_number],
        HEADER_TXT => '',
        ITEM_TEXT => '',
        ACCT_PROCEDURE => 'ZPAYAR',
        CLEARING_TEXT => '',
        CLEARING_TRAN => '',
        BDCMODE => 'N',
        PROFIT_CTR => '',
        DOC_TYPE => 'DZ',
        DOC_DATE => '20200402',
        PSTNG_DATE => '20200402',
        CURR => 'USD',
        VALID_ON => '20200402',
        RFC_FLAGS => '',
        COMP_CODE => '3000',
        PAYER_NR => '3000'
      }
    end

    def items_to_rfc
      data = Struct.new(:payer).new(@params[:payer])
      rfc_result = rfc_service_for(:open_items, data, @params).call

      items = rfc_result.data[:open_items].select do |item|
        @params[:invoices].include?(item.inv)
      end

      raise CorevistAPI::ServiceException.new('open_items.items_to_pay_not_found') if items.blank?

      @items = items.inject([]) do |memo, item|
        memo << {
            INV => item.inv,
            AC_DOC_NO => item.fi_nr,
            FISC_YEAR => item.fiscal_year,
            ITEM_NUM => item.item_num,
            PAY_AMNT => item.due_today
        }
        memo
      end

      { PAY_ITEMS_IN => @items }
    end

    def output
      super

      @data = Struct.new(:payment_doc_number).new(get_function_param(PAYMENT_DOC_NO))
    end
  end
end
