module CorevistAPI
  class Services::BaseServiceWithForm
    attr_accessor :errors

    def initialize(object, params)
      @form = object
      @params = params&.dup
      @errors = []
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

    def successful?
      @errors.empty?
    end

    private

    def invalid_object_error
      self.errors = @form.errors
      self
    end
  end
end
