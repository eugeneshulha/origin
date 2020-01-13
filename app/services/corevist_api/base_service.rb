module CorevistAPI
  class BaseService
    def initialize(object, params)
      @object = object
      @params = params&.dup
      @errors = {}
    end

    def call
      raise NotImplementedError
    end
  end
end
