module CorevistAPI
  module ActionPerformer
    extend ActiveSupport::Concern

    included do

      class << self
        def form_performer_for(*actions)
          actions.each do |action|
            define_method action do
              bm = Benchmark.ms do
                authorize(User)
                form = form_for(performer_name, params)
                params.merge!(type: performer_name)
                params.merge!(scope: policy_scope(scope_model)) if respond_to?(:scope_model, true)
                result = service_for(performer_name, form, params).call

                m = result.messages.presence || message
                success(m, result.data)
              end
              CorevistAPI::Context.measures[:total] = bm.real
            end
          end
        end

        def obj_performer_for(*actions)
          actions.each do |action|
            define_method action do
              bm = Benchmark.ms do
                authorize(User)
                params.merge!(type: performer_name)
                params.merge!(scope: policy_scope(scope_model)) if respond_to?(:scope_model, true)
                result = service_for(performer_name, @obj, params).call

                m = result.messages.presence || message
                success(m, result.data)
              end

              CorevistAPI::Context.measures[:total] = bm.real
            end
          end
        end
      end

      private

      def obj
        raise NotImplementedError
      end

      def performer_name
        "#{action_prefix}_#{action_name}".to_sym
      end

      def perform_action
        form = form_for(performer_name, params)
        params.merge!(type: performer_name)
        params.merge!(scope: policy_scope(scope_model)) if respond_to?(:scope_model, true)
        result = service_for(performer_name, form, params).call
        success(message, result.data)
      end

      def action_prefix
        self.class.name.remove('CorevistAPI::API::V1::').remove(/Controller/).gsub('::', '_').underscore
      end

      def message
        "api.infos.#{performer_name}"
      end
    end
  end
end
