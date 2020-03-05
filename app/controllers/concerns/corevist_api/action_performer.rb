module CorevistAPI
  module ActionPerformer
    extend ActiveSupport::Concern

    included do
      private

      def perform_action
        form = form_for(type, params)
        params.merge!(type: type)
        params.merge!(scope: policy_scope(scope_model)) if respond_to?(:scope_model, true)
        result = service_for(type, form, params).call
        success(message, result.data)
      end

      def action_prefix
        self.class.name.remove('CorevistAPI::API::V1::').remove(/Controller/).gsub('::', '_').downcase
      end

      def type
        raise NotImplementedError
      end

      def message
        "api.infos.#{type}"
      end
    end
  end
end
