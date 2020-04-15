module CorevistAPI
  class API::V1::SessionsController < Devise::SessionsController
    include CorevistAPI::Factories::FactoryInterface
    include CorevistAPI::ConfigsFor
    include JsonResponse

    configs_for :new

    MSG_SESSION_REFRESHED = 'devise.sessions.refreshed'.freeze
    MSG_SIGNED_IN         = 'devise.sessions.signed_in'.freeze

    def create
      @form = form_for(:sessions_create, params)

      if @form.valid?
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        success(MSG_SIGNED_IN, resource.jwt_data)
      end
    end

    def refresh_token
      result = service_for(:refresh_token, params[:token], params).call
      return error(result.errors) if result.failed?

      self.resource = result.data[:resource]
      warden.set_user(resource, resource.warden_options)
      sign_in(resource_name, resource)
      success(MSG_SESSION_REFRESHED, resource.jwt_data)
    end
  end
end
