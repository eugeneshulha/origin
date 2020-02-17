module CorevistAPI
  class Services::BaseService
    def initialize(object, params)
      @object = object
      @params = params&.dup
      @errors = {}
    end

    def call
      raise NotImplementedError
    end

    def result(data)
      @result ||= CorevistAPI::Services::ServiceResult.new(data)
    end

    private

    def rfc_service_for(type)
      CorevistAPI::Factories::RFCServicesFactory.instance.for(type, @object, @params)
    end

    def builder_for(type, *params)
      CorevistAPI::Factories::BuildersFactory.instance.for(type, *params)
    end
  end
end
