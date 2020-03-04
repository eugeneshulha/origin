class Hash
  def to_configuration
    JSON.parse self.to_json, object_class: CorevistAPI::PageConfig
  end
end
