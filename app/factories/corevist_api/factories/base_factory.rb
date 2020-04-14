module CorevistAPI
  class Factories::BaseFactory
    include Singleton

    def initialize
      @storage = {}
    end

    def for(name, *args)
      obj = @storage.with_indifferent_access[name]
      raise NoObjectException, "Factory with id #{name} not found in #{self.class}'s storage'" unless obj

      obj.safe_constantize.new(*args)
    end
  end
end
