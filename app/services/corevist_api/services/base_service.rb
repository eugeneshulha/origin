module CorevistAPI
  module Services
    class BaseService
      def initialize(object, params = {})
        @object = object
        @params = params.dup.with_indifferent_access
        @errors = {}
      end

      def call
        raise NotImplementedError
      end

      def result(data)
        @result ||= ServiceResult.new(data)
      end
    end
  end
end
