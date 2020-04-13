module CorevistAPI
  class ServiceException < ActiveRecord::ActiveRecordError

    def initialize(message)
      super(message)
    end
  end
end
