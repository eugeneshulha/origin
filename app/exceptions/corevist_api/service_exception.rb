module CorevistAPI
  class ServiceException < ActiveRecord::ActiveRecordError
    attr_reader :messages

    def initialize(message)
      super(message)
    end
  end
end
