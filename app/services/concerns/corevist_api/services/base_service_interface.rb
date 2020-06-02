module CorevistAPI
  module Services::BaseServiceInterface
    extend ActiveSupport::Concern

    included do
      private

      def object_class
        raise NotImplementedError
      end

      def namespace
        self.class.name.deconstantize.demodulize.downcase
      end

      def not_found_msg
        "api.#{namespace}.infos.not_found"
      end

      def did_not_change
        _('error|object is not changed')
      end

      def failed_destroy_msg
        "api.#{namespace}.errors.not_destroyed"
      end
    end
  end
end
