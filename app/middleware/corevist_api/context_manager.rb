require 'misc/context'

module CorevistAPI
  class ContextManager
    def initialize(app)
      @app = app
    end

    def call(env)
      @status, @headers, @response = @app.call(env)
      CorevistAPI::Context.clear(:current_user)
      [@status, @headers, @response]
    end
  end
end
