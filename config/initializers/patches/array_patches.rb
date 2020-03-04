require 'misc/find_one_by'

class Array
  include CorevistAPI::FindOneBy

  def single
    find { self.size == 1 }
  end

  def to_configuration
    JSON.parse self.to_json, object_class: CorevistAPI::PageConfig
  end
end
