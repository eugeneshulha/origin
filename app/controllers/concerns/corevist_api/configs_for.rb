module CorevistAPI
  module ConfigsFor
    extend ActiveSupport::Concern

    included do

      class << self
        def configs_for(*options)
          options.each do |action|
            action, opts = action.first if action.is_a?(Hash)
            opts ||= {}

            action = "#{action}_configs" if %i[index show].include?(action)

            define_method action do
              authorize(User) if opts.fetch(:authorize, true)
              @result = service_for(:page_configs_read, performer_name, object: params).call

              render 'corevist_api/api/v1/shared/configs', result: @result
            end
          end
        end
      end
    end
  end
end
