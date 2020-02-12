module CorevistAPI
  class Services::ServiceResult
    attr_reader :errors
    attr_accessor :data

    def initialize(data)
      @data = data
      @success = true
      @errors = []
    end

    def fail!(reason)
      @success = false
      reason.respond_to?(:each) ? reason.each(&@errors.method(:<<)) : @errors << I18n.t(reason)
      self
    end

    def success?
      @success && @errors.blank?
    end

    def failed?
      !@success
    end
  end
end
