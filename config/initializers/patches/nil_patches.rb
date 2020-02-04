class NilClass
  # to avoid the nil exceptions when applying the methods to the sent/returned data
  def drop_leading_zeros
    nil
  end

  def add_leading_zeros(number=10)
    ''
  end

  def rfc_str_to_date
    '00000000'
  end

  def dec_from_sap_to_i
    nil
  end

  def date_to_rfc_str
    '00000000'   # so we never get nil
  end

  def to_sap_bool
    'F'
  end

  def replace_sep
    ''
  end

  def valid?
    false
  end
end
