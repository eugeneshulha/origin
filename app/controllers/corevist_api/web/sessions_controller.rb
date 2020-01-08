module CorevistAPI::Web
  class SessionsController < Devise::SessionsController
    respond_to :html
  end
end
