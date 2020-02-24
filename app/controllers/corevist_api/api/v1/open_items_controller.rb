module CorevistAPI
  class API::V1::OpenItemsController < API::V1::BaseController
    before_action :authorize_user, only: :index

    MSG_OPEN_ITEMS_LOADED = 'api.open_items.success'.freeze

    def index
      @result = service_result
      error(@result.errors) if @result.failed?
      success(MSG_OPEN_ITEMS_LOADED, @result.data)
    end

    private

    def type
      "#{action_prefix}_#{action_name}".to_sym
    end
  end
end
