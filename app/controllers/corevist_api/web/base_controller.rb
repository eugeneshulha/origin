module CorevistAPI::Web
  class BaseController < ActionController::Base
    layout 'corevist_api/web/layouts/web'
    respond_to :html
  end
end
