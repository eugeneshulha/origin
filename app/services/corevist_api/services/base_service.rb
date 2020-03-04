module CorevistAPI
  class Services::BaseService
    include CorevistAPI::Factories::FactoryInterface
    include BaseServiceInterface

    def initialize(object, params)
      @object = object
      @params = params&.dup
      @errors = {}
    end

    def call
      raise NotImplementedError
    end

    def result(data)
      @result ||= ServiceResult.new(data)
    end

    private

    def current_user
      CorevistAPI::Context.current_user
    end
  end
end
