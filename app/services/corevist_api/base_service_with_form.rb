module CorevistAPI
  class Services::BaseServiceWithForm
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

    def to_json

    end
  end
end
