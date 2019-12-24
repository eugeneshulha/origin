module CorevistAPI
  class ApiResponse
    def initialize
      @body = { status: '', message: '' }
    end

    # code getter
    def code
      @body[:status]
    end

    # message getter
    def message
      @body[:message]
    end

    def set_message(*args)
      @body[:message] = I18n.t(args.join('.'))
    end

    def add(options = {})
      @body.merge!(options)
    end

    def delete(key)
      @body.delete(key)
    end

    def success!
      @body[:status] = 200
    end

    def to_json(*)
      @body.to_json
    end
  end
end
