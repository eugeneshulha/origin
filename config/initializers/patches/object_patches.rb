class Object
  def value_for_key(param)
    return nil unless self.respond_to?(param)

    self.send(param)
  end
end
