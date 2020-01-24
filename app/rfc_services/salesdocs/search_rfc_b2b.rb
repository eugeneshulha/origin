class Salesdocs::SearchRfcB2b < BaseRfc
  ADDITIONAL_DATA = [
    search_criteria: [
      :search_option,
      :value,
      { from_doc_date: [:date_to_rfc_str] },
      { to_doc_date: [:date_to_rfc_str] },
      :ship_status,
      :item_list
    ],
    sales_documents: [:size]
  ].freeze

  def initialize(*)
    super
    @data[:sales_documents] = []
    @data[:shipments] = []
    @data[:has_item_references] = false
    @converters = {
      po_number: Rfc::PoConverter.new,
      sold_to_number: Rfc::LeadingZerosConverter.new,
      ship_to_number: Rfc::LeadingZerosConverter.new,
      invoice_number: Rfc::LeadingZerosConverter.new,
      delivery_number: Rfc::LeadingZerosConverter.new,
      value: Rfc::LeadingZerosConverter.new,
      date: Rfc::DateConverter.new
    }
  end

  private

  def input
    rfc_object = object_to_rfc
    rfc_user = user_to_rfc(@object.user)
    set_params(rfc_object.merge(rfc_user))
  end

  def output
    super

    get_function_param(SALES_DOCUMENTS).each do |doc|
      document = Salesdocs::SalesDocument.new
      set_salesdoc(document, doc)
      @data[:sales_documents] << document
    end

    set_salesdocs_order
    get_function_param(SHIPMENTS).each do |row|
      shipment = Salesdocs::Shipment.new
      set_shipment(shipment, row)
      @data[:shipments] << shipment
    end

    doc_ref = @data[:sales_documents].any? { |doc| doc.reference.present? }
    ship_ref = @data[:shipments].any? { |ship| ship.reference.present? }

    if doc_ref || ship_ref
      @data[:has_item_references] = true
    end

    @data[:item_list] = get_function_param(ITEM_LIST)
  end

  def additional_data
    data_to_log(@object, ADDITIONAL_DATA)
  end

  def object_to_rfc
    { SEARCH_CRITERIA => search_criteria }
  end

  def search_criteria
    if @object.search_criteria.advanced?
      advanced_search_criteria
    else
      custom_search_criteria
    end
  end

  def advanced_search_criteria
    search_criteria = set_criteria
    search_criteria.merge!(advanced_criteria)
    set_date_range(search_criteria)
    values_to_s(compact_hash(search_criteria))
  end

  def custom_search_criteria
    search_criteria = set_criteria
    option = @object.search_criteria.sap_search_option

    if option.present?
      search_criteria[option] = convert(:value, @object.search_criteria.value)
    end

    set_date_range(search_criteria)
    search_by_po?(search_criteria)
    back_open_order_search?(search_criteria)
    values_to_s(compact_hash(search_criteria))
  end

  def set_salesdoc(document, doc)
    document.doc_number = doc[DOC_NR].drop_leading_zeros
    document.doc_type = doc[DOC_TYPE]&.strip
    document.doc_category = doc[DOC_CAT]
    document.sales_area = doc[SA]
    document.po_number = doc[PO_NR]
    document.doc_date = doc[DOC_DATE].rfc_str_to_date
    document.requ_del_date = doc[RDD].rfc_str_to_date
    document.valid_from = doc[VALID_FROM].rfc_str_to_date
    document.valid_to = doc[VALID_TO].rfc_str_to_date
    document.currency = doc[CURR]
    document.ship_status = doc[SHIP_STATUS]
    document.credit_status = doc[CREDIT_STATUS]
    document.item_number = doc[ITEM_NR].drop_leading_zeros
    document.material = doc[MAT]
    document.sales_uom = doc[SALES_UOM]&.strip
    document.description = doc[DESCR]
    document.reference = doc[REFERENCE]
    document.sold_to_number = doc[SOLD_TO_NR].drop_leading_zeros
    document.sold_to_descr = doc[SOLD_TO_DESCR]
    document.ship_to_number = doc[SHIP_TO_NR].drop_leading_zeros
    document.ship_to_descr = doc[SHIP_TO_DESCR]
    document.net_value = Amount.new(doc[NET_VALUE]&.sap_amnt_to_i, document.currency)
    document.quantity = Quantity.new(doc[QTY]&.sap_qty_to_i, document.sales_uom)
    document.po_type = doc[PO_TYPE]
  end

  def set_shipment(shipment, row)
    shipment.doc_number = row[DOC_NR].drop_leading_zeros
    shipment.doc_date = row[DOC_DATE].rfc_str_to_date
    shipment.po_number = row[PO_NR]
    shipment.ship_status = row[SHIP_STATUS]
    shipment.sales_uom = row[SALES_UOM]
    shipment.delivery_date = row[DEL_DATE].rfc_str_to_date
    shipment.delivery_number = row[DEL_NR].drop_leading_zeros
    shipment.tracking_number = row[TRACKING_NR].drop_leading_zeros
    shipment.carrier_number = row[CARRIER_NR].drop_leading_zeros
    shipment.credit_status = row[CREDIT_STATUS]
    shipment.reference = row[REFERENCE]
    shipment.quantity = Quantity.new(row[QTY].sap_qty_to_i, shipment.sales_uom)
  end

  def set_description
    if @object.search_criteria.sold_to_number.blank? && @object.user.sold_tos.size != 1
      TRUE_VAL
    else
      FALSE_VAL
    end
  end

  def advanced_criteria
    Salesdocs::SearchCriteria.advanced_options.each_with_object({}) do |(accessor, sap_column), memo|
      next if (value = @object.search_criteria.send(accessor)).blank?
      memo[sap_column] = convert(accessor, value)
    end
  end

  def set_criteria
    {
      WITH_DESCRIPTIONS => set_description,
      MAX_RESULTS => @object.search_criteria.max_results,
      TA_GROUP => @object.search_criteria.ta_group,
      DOC_TYPES => @object.search_criteria.selected_doc_types,
      ITEM_LIST => @object.search_criteria.item_list,
      SHIP_STATUS => @object.search_criteria.ship_status,
      SEARCH_OPTION => @object.search_criteria.search_option.to_s
    }
  end

  def set_date_range(search_criteria)
    if @object.search_criteria.from.present?
      search_criteria[FROM_DOC_DATE] = convert(:date, @object.search_criteria.from)
    end

    if @object.search_criteria.to.present?
      search_criteria[TO_DOC_DATE] = convert(:date, @object.search_criteria.to)
    end
  end

  def search_by_po?(search_criteria)
    return unless @object.search_criteria.by_po?
    search_criteria[PO_NR] = convert(:po_number, @object.search_criteria.value)
  end

  def back_open_order_search?(search_criteria)
    return unless @object.search_criteria.back_or_open?
    criteria_for_back_open(search_criteria)
  end

  def by_ship_or_sold_to?(search_criteria)
    if @object.user.assigned_ship_tos.empty?
      search_criteria[SOLD_TO_NR] =convert(:value, @object.search_criteria.value)
    else
      search_criteria[SHIP_TO_NR] =convert(:value, @object.search_criteria.value)
    end
  end

  def criteria_for_back_open(search_criteria)
    from_date = Time.zone.today - Const::App.configs[:backorders][:since]
    to_date = Time.zone.today + Const::App.configs[:backorders][:cut_off]
    by_ship_or_sold_to?(search_criteria)
    search_criteria[FROM_DOC_DATE] = convert(:date, from_date)
    search_criteria[TO_DOC_DATE] = convert(:date, to_date)
  end

  def set_salesdocs_order
    @data[:sales_documents].sort_by! { |doc| doc.doc_number.to_i }
    @data[:sort_criteria] = SortCriteria.new(:doc_number, :asc)
  end
end
