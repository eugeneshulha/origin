require 'misc/connection_interface'

class Object
  include CorevistAPI::ConnectionInterface

  def value_for_key(param)
    return nil unless self.respond_to?(param)

    self.send(param)
  end
end
