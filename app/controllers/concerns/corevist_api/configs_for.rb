module CorevistAPI
  module ConfigsFor
    extend ActiveSupport::Concern

    included do

      class << self
        def configs_for(*action)
          action.each do |action|
            define_method action do
              @result = service_for(:page_configs_read, type).call

              render 'corevist_api/api/v1/shared/configs', result: @result
            end
          end
        end
      end

      private

      def perform_action
        form = form_for(type, params)
        params.merge!(type: type)
        params.merge!(scope: policy_scope(scope_model)) if respond_to?(:scope_model, true)
        result = service_for(type, form, params).call
        success(message, result.data)
      end

      def action_prefix
        self.class.name.remove('CorevistAPI::API::V1::').remove(/Controller/).gsub('::', '_').underscore
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
