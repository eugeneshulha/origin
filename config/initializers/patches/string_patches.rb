class String
  AT_SIGN = '@'.freeze

  def utf8_hex_to_string
    result = ''
    # the string has to be in groups of 4 hex digits
    if self.size % 4 == 0 and self =~ /^([0-9A-F]+)$/
      self.scan(/..../).each do |s|
        result << [s.hex].pack('U')
      end
    end
    result
  end

  def replace_sep
    self.gsub(';',',')
  end

  def add_parameter_to_url(param, value)
    if self.index('?')
      separator = '&'
    else
      separator = '?'
    end
    "#{self}#{separator}#{param}=#{value}"
  end

  def b2b_sales_area
    sprintf("%1$s-%2$s-%3$s", selformat[0..3], selformat[4..5], selformat[6..7])
  end

  def contains_non_numeric_characters?
    self.match(/\D+/)
  end

  # Formats character fields coming from SAP to ruby:
  # - numeric: removes leading zeros
  # - alphanumeric: leaves them as-is
  def drop_leading_zeros
    # numeric: drop leading zeros
    f = self.strip
    if f.empty? or f =~ /\D/
      # alphanumeric: return as-is
      f
    elsif f.to_i == 0
      f = '0'
    else
      # numeric: drop leading zeros
      f.sub(/^0+/, '')
    end
  end

  # Formats character fields going to SAP from ruby:
  # - numeric: adds leading zeros
  # - alphanumeric: leaves them as-is
  def add_leading_zeros(zeros=10)
    if self.strip.empty? or self =~ /\D/
      # alphanumeric: return as-is
      self.strip
    elsif self.to_i == 0
      # just concatenate the amount of zeros
      str = ''
      zeros.times { str << '0'}
      str
    else
      #numeric: add leading zeros (after cutting off the leading zeros)
      sprintf("%0"+zeros.to_s+"d", self.strip.sub(/^0+/,''))
    end
  end

  # Formats decimal fields coming from SAP to integers in ruby
  #
  # e.g. '999.00' -> 99900
  def dec_from_sap_to_i
    self.sub('.', '').to_i
  end

  # Formats date string coming from SAP into date object in ruby
  #
  # e.g. 2007-02-07 -> date
  # we cannot use #to_date, because SAP may send the value 00000000 / !
  def rfc_str_to_date
    # use Date.new: faster
    if self =~ /^!|^0000/
      nil
    else
      Date.new(selformat[0..3].to_i, selformat[4..5].to_i, selformat[6..7].to_i)
    end
  end

  # only for empty
  def date_to_rfc_str
    '00000000'
  end

  # converts locale into SAP language (see T002T)
  def locale_to_sap
    case self
    when /^en/
      'E'
    when /^it/
      'I'
    when /^fr/
      'F'
    when /^de/
      'D'
    when /^nl/
      'N'
    when /^sv/
      'V'
    when /^ru/
      'R'
    when /^es/
      'S'
    when /^pt/
      'P'
    when /^ja/
      'J'
    when /^zh/
      '1'
    else
      'E'
    end
  end

  # Amounts (currency dependent): formats strings from view to ruby integers
  #
  # Three cases:
  # 1. empty   -> nil
  # 1. invalid -> string (as-is)
  # 1. valid   -> integer
  def view_amount_to_ruby(f=Settings.number_format_US, d=2)
    if self.strip.empty?
      nil    # nothing entered
    elsif d == 0 && self.index(format[0].chr)
      # if it contains decimals for non-decimal currencies: return as-is
      self
    else
      # format string into processable string
      # 1. remove the thousand separators (gsub)
      # 2. replace the decimal separator (sub)
      # TODO check that they are in the correct spots ?
      if d > 0
        aux = self.gsub(format[1].chr, '').sub(format[0].chr, '.')
      else
        # no step 2
        aux = self.gsub(format[1].chr, '')
      end
      # convert string to an integer
      begin
        if d == 0
          # no need to introduce decimals
          Float(aux).to_i
        # NOL - multiple . indicates an improper combination of number and format parameters (based on the replacement algorithm above)
        elsif aux.count(".") > 1
          self #return original string
        else
          #( Float(aux) * 100/(10**(2-d)) ).to_s.to_i  # has to be done this way, otherwise crazy rounding issues ??? e.g. (1999.0).to_i = 1998: could have been a 1.8.6 issue
          # NOL - not exactly sure why this is needed, but it wasn't working post Rails 3 upgrade without the following changes

          # NOL - get rid of extra chars after the defined format decimal places
          aux = aux.slice(0..(aux.index('.') + d))

          #( Float(aux) * 100/(10**(2-d)) ).to_s.slice(0..(aux.length - d + 1)).to_s.to_i
          #( Float(aux) * 100/(10**(2-d)) ).to_s.slice(0..(aux.length - (2 - d))).to_s.to_i
          #("%0.0f" % (Float(aux) * 100/(10**(2-d)))).to_i
          #("%0.0f" % (Float(aux.truncate(aux.length - d, omission: '')) * 100/(10**(2-d)))).to_i
          ("%0.0f" % ((aux.to_f * 100/(10**(2-d))).to_f.round)).to_i
        end
      rescue
        # if it can't be converted: return as-is
        self
      end
    end
  end

  # Quantities: formats strings from view to ruby integers
  #
  # Three cases:
  # 1. empty   -> nil
  # 1. invalid -> string (as-is)
  # 1. valid   -> integer
  # Formats strings to quantities (unit of measure dependent)
  def view_quantity_to_ruby(f=Const::App.number_format_US, dec=true)
    if self.strip.empty?
      nil   # nothing entered
    elsif !dec && self.index(format[0].chr)
      # if it contains decimals for non-decimal units: return as-is
      self
    else
      # format string into processable string
      # 1. remove the thousand separators (gsub)
      # 2. replace the decimal separator (sub)
      # TODO check that they are in the correct spots ?
      if dec
        aux = self.gsub(format[1].chr, '').sub(format[0].chr, '.')
      else
        # no step 2
        aux = self.gsub(format[1].chr, '')
      end
      # convert string to an integer
      begin
        ( Float(aux) * 1000 ).to_i
      rescue
        # if it can't be converted: return as-is
        self
      end
    end
  rescue
    self
  end

  # Dates: formats strings from view to ruby dates:
  # try to convert to a date, if we cannot be converted to a date, leave it as is
  def view_date_to_ruby(f=Const::App.date_format_US)
    if self.strip.empty?
      ''  # nothing entered
    else
      begin
        Date.strptime(self, f)
      rescue
        # if it can't be converted: return as-is
        self
      end
    end
  end

  # Boolean: formats SAP 'T/F/!' to true, false, '!'
  def sap_to_boolean
    # The standard X/space doesn't work, because space turns to nil instead of false.
    # Therefore: all webservices communicate using T/F/'!'(don't display the field)
    if self == 'T'
      true
    elsif self == 'F'
      false
    elsif self == ''
      false
    else
      '!'   # don't display
    end
  end

  # Formats a wildcard search string to go to SAP: adds * based on the rules(SAP has to handle the upper casing, so it follows SAP's rules)
  def to_sap_search_string(max_length = nil, requirements = '^[^\*]{3}')
    if self.blank? || self.length == max_length
      s = self
    elsif self.length < max_length
      s = self =~ /\*$/ ? self : self + '*'
      if s.length < max_length && requirements =~ /\^\[\^\\\*\]/
        s = '*' + s unless s =~ /^\*/
      end
    end
    s
  end

  def unatify
    remove(AT_SIGN)
  end

  def to_number_with_format
    format = CorevistAPI::Context.current_user.number_format

    sprintf("%0.0f", Float(self)).sub('.', format[0].chr).gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{format[1].chr}")
  end

  def to_amount_with_format(currency_sym)
    format = CorevistAPI::Context.current_user&.number_format
    return self unless format

    decimals = Settings.decimals[currency_sym] || 2

    sprintf("%0.#{decimals}f", Float(self)).sub('.', format[0].chr).gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{format[1].chr}")
  end

  def to_date_with_format(format)
    return self if self.blank?

    Date.parse(self).strftime(format)
  rescue
    self
  end

  def user_format_to_number
    format = CorevistAPI::Context.current_user&.number_format

    num = self.gsub(format[1].chr, '').sub(format[0].chr, '.')
    Float(num)
  rescue
    self

  end

  def is_numeric?
    self.gsub(/\W/, '').scan(/^\d+$/).present?
  end

  # For dates like: 20200101, 2020/01/01, 01.01.2020
  def is_date?
    self !~ /^0+/ && self.length == 8 || %w[/ .].any? { |sep| self.include?(sep) } && self.length == 10
  end
end
