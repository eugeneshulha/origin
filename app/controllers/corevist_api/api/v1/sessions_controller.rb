module CorevistAPI
  class API::V1::SessionsController < Devise::SessionsController
    include CorevistAPI::Factories::FactoryInterface
    include CorevistAPI::ConfigsFor
    include JsonResponse

    configs_for new: { authorize: false }

    MSG_SESSION_REFRESHED = 'devise.sessions.refreshed'.freeze

    def create
      form = form_for(:sessions_create, params)
      service = service_for(:login, form, self)
      result = service.call

      success(message, result&.data&.jwt_data)
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
