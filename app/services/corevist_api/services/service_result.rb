module CorevistAPI::Services
  class ServiceResult
    attr_reader :errors, :messages
    attr_accessor :data

    def initialize(data)
      @data = data
      @success = true
      @errors = []
      @messages = []
    end

    def fail!(reason)
      @success = false
      reason.respond_to?(:each) ? reason.each(&@errors.method(:<<)) : @errors << _("error|#{reason}")
      self
    end

    def successful?
      @success && @errors.blank?
    end

    def failed?
      !@success
    end
  end
end
