module CorevistAPI
  class BaseServiceWithForm
    def initialize(object, params)
      @form = object
      @params = params&.dup
      @errors = {}
    end

    def call
      if @form.valid?
        perform
      else
        invalid_object_error
      end
    end

    def perform
      raise NotImplementedError
    end
  end
end
