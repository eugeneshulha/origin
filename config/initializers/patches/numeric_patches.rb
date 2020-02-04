class Numeric
  # Values/Quantities: formats integer from ruby to string (with specified number of decimals) going to SAP
  #
  # e.g. 99900 -> '999.00'
  def int_to_sap_str(decimals)
    sprintf("%0."+decimals.to_s+"f", self.to_f / (10 ** decimals))
  end

  def i_to_sap_qty
    Float(self) / 1000
  end

  def i_to_sap_amnt
    Float(self) / 100
  end

  def amount(currency='DEF')
    Amount.new( ( Float(self) * 100/(10**(2-Const::App.decimals[currency])) ).to_i , currency)
  end
end
