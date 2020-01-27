module CorevistAPI
  class BaseFactory
    include Singleton

    def initialize
      @storage = {}
    end

    def for(name, *args)
      @storage.with_indifferent_access[name].safe_constantize.new(*args)
    end
  end
end
