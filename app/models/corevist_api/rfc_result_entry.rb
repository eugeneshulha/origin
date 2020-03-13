module CorevistAPI
  class RfcResultEntry
    def initialize(_, data)
      data.each do |k, v|
        #
        # No arrays or RfcResultEntries needed to be processes.
        #
        v = (v.is_a?(self.class) || v.is_a?(Array)) ? v : v.to_s.strip
        instance_variable_set("@#{k.underscore}", v)
        class_eval { attr_reader k.underscore.to_sym }
      end
    end
  end
end
