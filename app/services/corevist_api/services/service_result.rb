module CorevistAPI
  class Services::ServiceResult
    attr_reader :data, :errors

    def initialize(data)
      @data = data
      @success = true
      @errors = []
    end

    def fail!(errors = [])
      @success = false
      errors.each(&@errors.method(:<<))
      self
    end

    def successful?
      @success && @errors.blank?
    end
  end
end
