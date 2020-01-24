class Sap::Error < StandardError
  TYPE = :sap

  attr_reader :sap_return

  def initialize(sap_return)
    @sap_return = sap_return
    super(sap_message)
  end

  private

  def sap_message
    #based on SAP error numbers
    case "#{@sap_return.id}-#{@sap_return.number}"
      # sim_or_create
      when 'F2-042'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _('msg|Account %{number} is currently locked by another user') % {number: @sap_return.message_v1}
      when 'V4-115'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _('msg|po number already exists in order %{number}') % {number: @sap_return.message_v1}
      when 'VP-200'
        msg = _("msg|invalid customer number")
      when 'V1-154'
        msg = _("msg|customer %{number} is blocked") % {number: @sap_return.message_v1}
      when 'V1-423'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _("msg|customer %{number} is blocked") % {number: @sap_return.message_v1}
      # tax jurisdiction code
      when 'TAX_TXJCD-101'
        msg = _('msg|invalid zip code')
      when 'TAX_TXJCD-861', 'TAX_TXJCD-863', 'TAX_TXJCD-864'
        msg = _('msg|issue with external tax system')
      # order change
      when 'V1-042'
        msg = _("msg|order being processed")
      # get_salesdoc
      when '/COREVIST/OLD-001', 'b2b2dot0-001'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _('msg|document %{salesdoc} does not exist') % {salesdoc: @sap_return.message_v1}
      when '/COREVIST/OLD-002', 'b2b2dot0-002'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _('msg|not authorized for %{ship_to} in sales area') % {ship_to: @sap_return.message_v1}
      when '/COREVIST/OLD-003', 'b2b2dot0-003'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _('msg|not authorized for %{sold_to} in sales area') % {sold_to: @sap_return.message_v1}
      when '/COREVIST/OLD-004', 'b2b2dot0-004'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _('msg|not authorized for territory %{territory} in sales area') % {territory: @sap_return.message_v1}
      when '/COREVIST/OLD-005', 'b2b2dot0-005'
        msg = _('msg|not authorized for sales aera')
      when '/COREVIST/OLD-006', 'b2b2dot0-006'
        msg = _('msg|not authorized for doc.type in sales area')
      # get_salesdoc_list
      when '/COREVIST/OLD-021', 'b2b2dot0-021'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _("msg|not allowed to see salesdocs of sold-to %{sold_to}") % {sold_to: @sap_return.message_v1}
      when '/COREVIST/OLD-022', 'b2b2dot0-022'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _("msg|not allowed to see salesdocs of ship-to %{ship_to}") % {ship_to: @sap_return.message_v1}
      when '/COREVIST/OLD-023', 'b2b2dot0-023'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _("msg|delivery %{number} does not exist") % {number: @sap_return.message_v1}
      when '/COREVIST/OLD-024', 'b2b2dot0-024'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _("msg|invoice %{number} does not exist") % {number: @sap_return.message_v1}
      when '/COREVIST/GENERAL-015', 'Z_B2B2DOT0-015' #Z6439
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _("msg|shipment %{number} does not exist") % {number: @sap_return.message_v1}
      # get_partner
      when '/COREVIST/OLD-050', 'b2b2dot0-050'
        msg = _("msg|invalid customer number")
      when '/COREVIST/OLD-051', 'b2b2dot0-051'
        msg = _('msg|not allowed to work with this partner')
      # the following two messages are issued by the cart (when entering the prerequisites)
      when '/COREVIST/OLD-552', 'b2b2dot0-552'
        @sap_return.message_v1 = @sap_return.message_v1.strip
        msg = _("msg|partner not valid for doc.type %{doc_type}") % {doc_type: _("lbl|salesdoc_type_#{@sap_return.message_v1}")}
      when '/COREVIST/OLD-553', 'b2b2dot0-553'
        msg = _('msg|enter partner number')
      # get partners / get sales partners
      when '/COREVIST/OLD-060', 'b2b2dot0-060'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        @sap_return.message_v2 = @sap_return.message_v2.strip
        msg = _("msg|partner %{number} does not exist with function %{function}") % {number: @sap_return.message_v1, function: _("lbl|function_#{@sap_return.message_v2}")}
      # load assigned partners
      when '/COREVIST/OLD-070', 'b2b2dot0-070'
        msg = _('msg|no partners found')
      when '/COREVIST/OLD-700', 'b2b2dot0-700'
        @sap_return.message_v1 = @sap_return.message_v1.strip
        msg = _("msg|missing %{function} for cart processing") % {function: _("lbl|function_#{@sap_return.message_v1}")}
      # get_pdf
      when '/COREVIST/OLD-101', 'b2b2dot0-101', '/COREVIST/GENERAL-011'
        msg = _('msg|error while generating PDF')
      when '/COREVIST/OLD-102', 'b2b2dot0-102'
        msg = _('msg|error while generating PDF')
      when '/COREVIST/OLD-103', 'b2b2dot0-103'
        msg = _('msg|error while generating PDF')
      when '/COREVIST/OLD-200', 'b2b2dot0-200'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _('msg|invoice %{number} does not exist') % {number: @sap_return.message_v1}
      when '/COREVIST/OLD-201', 'b2b2dot0-201'
        msg = _('msg|not authorized for sales aera')
      when '/COREVIST/OLD-202', 'b2b2dot0-202'
        msg = _('msg|not authorized for doc.type in sales area')
      when '/COREVIST/OLD-203', 'b2b2dot0-203'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _('msg|not authorized for %{payer} in sales area') % {payer: @sap_return.message_v1}
      when '/COREVIST/OLD-204', 'b2b2dot0-204'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _('msg|invoice %{number} is canceled') % {number: @sap_return.message_v1}
      when '/COREVIST/OLD-211', 'b2b2dot0-211'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _("msg|not allowed to see invoices of payer %{payer}") % {payer: @sap_return.message_v1}
      when '/COREVIST/OLD-220', 'b2b2dot0-220'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _("msg|payer %{payer} does not exist in allowed comp.codes") % {payer: @sap_return.message_v1}
      when '/COREVIST/OLD-221', 'b2b2dot0-221'
        @sap_return.message_v1 = @sap_return.message_v1.drop_leading_zeros
        msg = _("msg|payer %{payer} does not exist in comp.code %{company_code}") % {payer: @sap_return.message_v1, company_code: _("lbl|comp_code_#{@sap_return.message_v2}")}
      # from mock RFC for tests
      when '/COREVIST/OLD-260', 'b2b2dot0-260' #E44
        msg = _("msg|posting date is no longer %{since}, cash discounts needed to be recalculated, please try again") % {:since => @sap_return.message_v1.rfc_str_to_date}
      when 'V1-124'
        msg = _('msg|dummy sap message from mock')
      # general error triggered by mock RFC for testing
      when 'dummy-999'
        msg = _('msg|dummy sap message from mock')
      when 'b2b_pmpay-000' # charge successful but no clearing   #E44
        msg = _('msg|pmpay: charge successful but no clearing')
      when 'b2b_pmpay-005' # web AR example
        msg = _('msg|pmpay: other reason')
      when 'b2b_pmpay-006' # web AR example
        msg = _('msg|pmpay: connection restarted')
      when 'V/-005'
        msg = _('msg|credit card already used')
      when '/COREVIST/OLD-025'
        msg = @sap_return.message
      when '/COREVIST/GENERAL-060'
        msg = _('msg|partner_index_not_maintained') % { tr: @sap_return.message_v1, fun: @sap_return.message_v2 }
    end

    msg
  end
end
