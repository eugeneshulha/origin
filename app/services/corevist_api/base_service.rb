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

    def result(data)
      @result ||= ServiceResult.new(data)
    end
  end
end
