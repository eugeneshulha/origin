module CorevistAPI
  class API::V1::SessionsController < Devise::SessionsController
    include Configurable
    include JsonResponse

    def self.config_file_name
      'login'
    end

    def create
      self.resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)
      success('devise.sessions.signed_in', account_id: resource.uuid)
    end
  end
end
