module CorevistAPI
  class RfcException < StandardError
    TYPE = :rfc
    attr_accessor :info

    def initialize(msg = nil)
      super(msg)

      @info = if msg.respond_to?(:error) && msg.error.present?
                msg.error
              else
                Hash.new
              end
    end
  end

end
