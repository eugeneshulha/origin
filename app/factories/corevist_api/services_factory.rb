module CorevistAPI
  class ServicesFactory < CorevistAPI::BaseFactory
    def initialize
      @storage = {
          create_user: 'CorevistAPI::Admin::CreateUserService',
          user_registration: 'CorevistAPI::User::RegistrationService',
          find_invoice: 'CorevistAPI::Invoice::FindService',
          search_invoices: 'CorevistAPI::Invoice::SearchService'
      }
    end
  end
end
