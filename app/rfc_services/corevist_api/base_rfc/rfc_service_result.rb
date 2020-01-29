module CorevistAPI
  class BaseRFC::Result
    attr_reader :sap_return, :data, :options

    def initialize(sap_return, data, options = {})
      @sap_return = sap_return
      @data = data
      @options = options
    end
  end

end