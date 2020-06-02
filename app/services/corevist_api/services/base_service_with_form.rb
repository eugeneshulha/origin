module CorevistAPI::Services
  class BaseServiceWithForm < BaseService
    attr_accessor :errors

    def initialize(object, params)
      @form = object
      @params = params&.dup
      @errors = []
    end

    def call
      return perform if @form.valid?

      invalid_object_error
    end

    def result(data = nil, options = {})
      if @result.present?
        @result.data = data
        return @result
      end

      @result = CorevistAPI::Services::ServiceResult.new(data)
      options[:messages].each(&@result.messages.method(:<<)) if options[:messages].respond_to?(:each)
      @result.messages << options[:message] if options[:message].present?
      @result
    end

    private

    def invalid_object_error
      raise CorevistAPI::ServiceException.new(@form.errors.full_messages)
    end

    def fields(object)
      @form.instance_variable_names.map(&:unatify) & object.class.extra_column_names
    end

    def user
      id = @form.try(:uuid) || @form.try(:id)
      CorevistAPI::User.find_by(uuid: id)
    end
  end
end
