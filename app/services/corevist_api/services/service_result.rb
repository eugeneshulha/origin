module CorevistAPI
  module Services
    class ServiceResult
      attr_reader :data, :errors

      def initialize(data)
        @data = data
        @success = true
        @errors = []
      end

      def fail!(errors = [])
        @success = false
        errors.each(&@errors.method(:<<))
        self
      end

      def success?
        @success && @errors.blank?
      end
    end
  end
end
