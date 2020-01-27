module CorevistAPI
  class ServicesFactory < CorevistAPI::BaseFactory
    def initialize
      @storage = {
        create_user: 'CorevistAPI::Services::Admin::CreateUserService',
        filter_user: 'CorevistAPI::Admin::FilterUserService',
        user_registration: 'CorevistAPI::Services::User::RegistrationService',
        find_invoice: 'CorevistAPI::Services::Invoice::Display',
        find_salesdoc: 'CorevistAPI::Services::Salesdoc::Display',
        search_invoices: 'CorevistAPI::Services::Invoice::Search',
        search_salesdocs: 'CorevistAPI::Services::Salesdoc::Search'
      }
    end
  end
end
