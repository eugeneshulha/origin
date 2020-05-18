class Date
  # Formats dates from Ruby into strings going to SAP
  #
  # e.g. Date -> "20070207"
  def date_to_rfc_str
    strftime('%Y%m%d')
  end
end
