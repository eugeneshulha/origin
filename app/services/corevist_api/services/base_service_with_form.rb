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
        if @result.present?
          @result.data = data
          return @result
        end

        @result = ServiceResult.new(data)
      end

      private

      def invalid_object_error
        result.fail!(@form.errors.full_messages)
      end

      def fields(object)
        (@form.instance_variable_names.map(&:unatify) & object.class.extra_column_names) - @form.rejected_keys
      end

      def user
        CorevistAPI::User.find_by_uuid(@form.uuid)
      end
    end
  end
end
