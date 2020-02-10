module CorevistAPI
  module Services
    class BaseServiceWithForm
      def initialize(object, params)
        @form = object
        @params = params&.dup
        @errors = {}
      end

      def call
        return perform if @form.valid?

        invalid_object_error
      end

      def perform
        raise NotImplementedError
      end

      def invalid_object_error
        raise NotImplementedError
      end

      def to_json(obj = nil); end

      def result(data = nil)
        @result ||= ServiceResult.new(data)
      end

      private

      def rfc_service_for(type)
        CorevistAPI::Factories::RFCServicesFactory.instance.for(type, @form, type, @params)
      end
    end
  end
end
