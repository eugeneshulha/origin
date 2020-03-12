module CorevistAPI
  class ServiceException < ActiveRecord::ActiveRecordError
    attr_reader :messages

    def initialize(messages)
      super()
      @messages = []
      messages.respond_to?(:each) ? messages.each(&@messages.method(:<<)) : @messages << I18n.t(messages)
    end
  end
end
