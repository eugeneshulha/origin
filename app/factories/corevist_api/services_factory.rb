module CorevistAPI
  class ServicesFactory < CorevistAPI::BaseFactory
    def initialize
      @storage = {
          create_user: 'CorevistAPI::Admin::CreateUserService',
      }
    end
  end
end
