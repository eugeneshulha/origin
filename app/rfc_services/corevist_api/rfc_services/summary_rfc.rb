module CorevistAPI
  class RFCServices::SummaryRFC < CorevistAPI::RFCServices::BaseRFCService
    SUMMARIZED_SALESDOCS            = 'SUMMARIZED_SALESDOCS'.freeze
    FLAGS                           = 'FLAGS'.freeze
    TYPE_OF_SALESDOCS               = 'TYPE_OF_SALESDOCS'.freeze
    NUMBER_OF_SALESDOCS             = 'NUMBER_OF_SALESDOCS'.freeze
    TYPE_OF_DELIVERIES              = 'TYPE_OF_DELIVERIES'.freeze
    NUMBER_OF_DELIVERIES            = 'NUMBER_OF_DELIVERIES'.freeze
    TYPE_OF_INVOICES                = 'TYPE_OF_INVOICES'.freeze
    NUMBER_OF_INVOICES              = 'NUMBER_OF_INVOICES'.freeze
    WITH_DESCR                      = 'WITH_DESCR'.freeze
    SUMMARIZED_INVOICES             = 'SUMMARIZED_INVOICES'.freeze
    SUMMARIZED_DELIVERIES           = 'SUMMARIZED_DELIVERIES'.freeze
    DEFAULT_TYPE_OF_SALESDOCS       = 'P'.freeze
    DEFAULT_NUMBER_OF_SALESDOCS     = '5'.freeze
    DEFAULT_TYPE_OF_DELIVERIES      = 'R'.freeze
    DEFAULT_NUMBER_OF_DELIVERIES    = '10'.freeze
    DEFAULT_TYPE_OF_INVOICES        = 'O'.freeze
    DEFAULT_NUMBER_OF_INVOICES      = 'A'.freeze

    def function_name
      :summary
    end

    def input
      rfc_object = object_to_rfc
      rfc_user = user_to_rfc(user)
      set_params(rfc_object.merge(rfc_user))
    end

    def output
      super
      @data[:summarized_salesdocs] = get_function_param(SUMMARIZED_SALESDOCS).map do |summarized_salesdoc|
        RfcResultEntry.new(self.class.name.demodulize.underscore, summarized_salesdoc)
      end
      @data[:summarized_invoices] = get_function_param(SUMMARIZED_INVOICES).map do |summarized_invoice|
        RfcResultEntry.new(self.class.name.demodulize.underscore, summarized_invoice)
      end
      @data[:summarized_deliveries] = get_function_param(SUMMARIZED_DELIVERIES).map do |summarized_deliveries|
        RfcResultEntry.new(self.class.name.demodulize.underscore, summarized_deliveries)
      end
    end

    # type_of_salesdocs:
    # U=recently placed orders of user, P=recently placed orders of partner (sold-to, ship-to), N=no sales docs
    # number_of_salesdocs:
    # 5, A=all
    # type_of_deliveries:
    # R=recent deliveries of sold-to/ship-to, N=no deliveries
    # number_of_deliveries: 10
    # for R: since x days
    # type_of_invoices:
    # O=overdue, D=due, N=no invoices
    # number_of_invoices:
    # number, A=all
    def object_to_rfc
      {
        SUMMARIZED_SALESDOCS => @object.instance_variable_get(:@summarized_salesdocs).to_a,
        FLAGS => {
          WITH_DESCR => with_descriptions,
          TYPE_OF_SALESDOCS => DEFAULT_TYPE_OF_SALESDOCS,
          NUMBER_OF_SALESDOCS => DEFAULT_NUMBER_OF_SALESDOCS,
          TYPE_OF_DELIVERIES => DEFAULT_TYPE_OF_DELIVERIES,
          NUMBER_OF_DELIVERIES => DEFAULT_NUMBER_OF_DELIVERIES,
          TYPE_OF_INVOICES => DEFAULT_TYPE_OF_INVOICES,
          NUMBER_OF_INVOICES => DEFAULT_NUMBER_OF_INVOICES
        }
      }
    end

    private

    def payer_number
      (@object.instance_variable_get(:@payer_number) || user.payers.first&.number).add_leading_zeros
    end

    def with_descriptions
      if user.assigned_sold_tos.empty? && user.assigned_ship_tos.empty? ||
         user.assigned_sold_tos.size > 1 || user.assigned_ship_tos.size > 1
        return TRUE_VAL
      end

      FALSE_VAL
    end
  end
end
