require 'misc/context'

module CorevistAPI
  class ContextManager
    def initialize(app)
      @app = app
    end

    def call(env)
      @status, @headers, @response = @app.call(env)

      CorevistAPI::Context.print_measures
      CorevistAPI::Context.clear(:current_user, :measures)
      [@status, @headers, @response]
    end
  end
end
