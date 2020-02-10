module CorevistAPI
  module Services
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

      def perform
        raise NotImplementedError
      end

      def result(data = nil)
        @result ||= ServiceResult.new(data)
      end

      private

      def invalid_object_error
        result.fail!(@form.errors.full_messages)
      end

      def rfc_service_for(type)
        CorevistAPI::Factories::RFCServicesFactory.instance.for(type, @form, type, @params)
      end
    end
  end
end
