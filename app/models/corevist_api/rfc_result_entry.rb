module CorevistAPI
  class RfcResultEntry
    def initialize(_, data)
      data.each do |k, v|
        instance_variable_set("@#{k.underscore}", v.to_s.strip)
        class_eval { attr_reader k.underscore.to_sym }
      end
    end
  end
end
