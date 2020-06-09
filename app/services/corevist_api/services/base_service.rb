module CorevistAPI:: Services
  class BaseService
    include CorevistAPI::Factories::FactoryInterface
    include CorevistAPI::Services::BaseServiceInterface
    include CorevistAPI::Services::Paginatable
    include CorevistAPI::Services::Sortable


    def initialize(object, params)
      @object = object
      @params = params&.dup
      @errors = {}
    end

    def call
      raise NotImplementedError
    end

    def result(data = {})
      @result ||= CorevistAPI::Services::ServiceResult.new(data)
    end

    private

    def current_user
      CorevistAPI::Context.current_user
    end
  end
end
