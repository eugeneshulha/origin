module CorevistAPI
  module ConfigsFor
    extend ActiveSupport::Concern

    included do

      class << self
        def configs_for(*action)
          action.each do |action|
            action = "#{action}_configs" if %i[index show].include?(action)

            define_method action do
              @result = service_for(:page_configs_read, performer_name).call

              render 'corevist_api/api/v1/shared/configs', result: @result
            end
          end
        end
      end
    end
  end
end
