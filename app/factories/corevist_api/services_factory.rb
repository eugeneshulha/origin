module CorevistAPI
  class ServicesFactory < CorevistAPI::BaseFactory
    def initialize
      @storage = {
          create_user: 'CorevistAPI::Admin::CreateUserService',
          user_registration: 'CorevistAPI::User::RegistrationService'
      }
    end
  end
end
