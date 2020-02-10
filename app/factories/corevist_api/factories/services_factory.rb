module CorevistAPI
  class Factories::ServicesFactory < CorevistAPI::Factories::BaseFactory
    def initialize
      @storage = {
        create_user: 'CorevistAPI::Services::Admin::CreateUserService',
        filter_user: 'CorevistAPI::Admin::FilterUserService',
        user_registration: 'CorevistAPI::Services::User::RegistrationService',
        find_invoice: 'CorevistAPI::Services::Invoice::Display',
        find_salesdoc: 'CorevistAPI::Services::Salesdoc::Display',
        search_invoices: 'CorevistAPI::Services::Invoice::Search',
        search_salesdocs: 'CorevistAPI::Services::Salesdoc::Search',
        admin_partners_search: 'CorevistAPI::Services::Admin::Partners::SearchService',
        admin_users_partners_create: 'CorevistAPI::Services::Admin::Partners::CreateService'
      }
    end
  end
end
