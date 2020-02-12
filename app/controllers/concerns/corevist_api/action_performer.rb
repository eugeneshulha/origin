module CorevistAPI
  module ActionPerformer
    extend ActiveSupport::Concern

    included do
      private

      def perform_action(type)
        form = form_for(:"#{action_prefix}_#{type}", params)
        @result = service_for(:"#{action_prefix}_#{type}", form, params).call
        error(@result.errors) if @result.failed?
      end

      def action_prefix
        self.class.name.remove('CorevistAPI::API::V1::').remove(/Controller/).gsub('::', '_').downcase
      end
    end
  end
end
