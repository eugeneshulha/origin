module CorevistAPI
  class Factories::ConfigsFactory < CorevistAPI::Factories::BaseFactory
    def initialize
      @for_guests = [:login, :registration, :forgot_password_1, :forgot_password_2].freeze

      @storage = {
          login: :login,
          dashboard: :dashboard,
          registration: :registration,

          forgot_password_1: :forgot_password_1,
          forgot_password_2: :forgot_password_1
      }.freeze
    end

    def unauthorized_config?(config)
      @for_guests.include?(config.to_sym)
    end

    def for(name, *args)
      @storage.with_indifferent_access[name]
    end
  end
end
