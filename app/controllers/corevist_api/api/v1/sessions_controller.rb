module CorevistAPI
  class API::V1::SessionsController < Devise::SessionsController

    def create
      self.resource = warden.authenticate!(auth_options)
      api_response.success!
      api_response.add(account_id: resource.uuid)
      api_response.set_message(:devise, :sessions, :signed_in)
      sign_in(resource_name, resource)
      respond_with resource
    end

    private

      def respond_with(resource, _opts = {})
        render json: api_response
      end
  end
end
