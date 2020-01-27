module CorevistAPI
  class ServiceResult
    attr_reader :data

    def initialize(data)
      @data = data
      @success = true
    end

    def fail!
      @success = false
    end

    def success?
      @success
    end
  end
end
