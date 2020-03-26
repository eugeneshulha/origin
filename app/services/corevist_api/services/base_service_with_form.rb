module CorevistAPI
  module Services
    class BaseServiceWithForm < BaseService
      DEFAULT_PAGE_SIZE = 5

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

        @result = CorevistAPI::Services::ServiceResult.new(data)
      end

      private

      def invalid_object_error
        raise CorevistAPI::ServiceException.new(@form.errors.full_messages)
      end

      def fields(object)
        @form.instance_variable_names.map(&:unatify) & object.class.extra_column_names
      end

      def user
        CorevistAPI::User.find_by_id(@form.id)
      end
    end
  end
end
