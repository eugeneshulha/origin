class Float
  # Formats quantity fields coming from SAP (Float) to integers in ruby
  #
  # e.g. 999.120 -> 999120
  def sap_qty_to_i
    (self * 1000).to_s.to_i
  end

  # Formats amount fields coming from SAP (Float) to integers in ruby
  # Note: without the to_s Float(2.3).sap_amnt_to_i returns 229... To avoid this bug, to_s was added to all Float.to_i methods
  #
  # e.g. 999.10 -> 99910
  def sap_amnt_to_i
    # NOL - added rounding to correct for float inaccuracies
    #(self * 100).to_s.to_i
    (self * 100).round.to_s.to_i
  end

  # Formats amount fields coming from SAP (Float) to integers in ruby with the given amount of decimals
  #
  # e.g. -1.23456 -> -123456
  def sap_float_to_i(dec)
    # NOL - added rounding to correct for float inaccuracies
    #(self * 10**dec).to_s.to_i
    (self * 10**dec).round.to_s.to_i
  end
end
