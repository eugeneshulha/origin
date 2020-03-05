module CorevistAPI
  module FindOneBy
    def find_one_by(options = {})
      k = options.keys.first
      v = options.values.first
      self.find { |component| component.send(k) == v  }
    end

    def where(options = {})
      k = options.keys.first
      v = options.values.first
      self.select { |component| component.send(k) == v  }
    end
  end
end
