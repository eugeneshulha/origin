module CorevistAPI
  class Factories::ServicesFactory < CorevistAPI::Factories::BaseFactory
    def initialize
      @storage = {
        admin_users_step_1: 'CorevistAPI::Services::Admin::Users::Step1CreationService',
        admin_users_step_2: 'CorevistAPI::Services::Admin::Users::Step2CreationService',
        admin_users_step_3: 'CorevistAPI::Services::Admin::Users::Step3CreationService',
        admin_users_step_4: 'CorevistAPI::Services::Admin::Users::Step4CreationService',
        admin_users_step_5: 'CorevistAPI::Services::Admin::Users::Step5CreationService',
        admin_users_step_6: 'CorevistAPI::Services::Admin::Users::Step6CreationService',
        filter_user: 'CorevistAPI::Admin::FilterUserService',
        user_registration: 'CorevistAPI::Services::User::RegistrationService',
        find_invoice: 'CorevistAPI::Services::Invoice::Display',
        find_salesdoc: 'CorevistAPI::Services::Salesdoc::Display',
        search_invoices: 'CorevistAPI::Services::Invoice::Search',
        search_salesdocs: 'CorevistAPI::Services::Salesdoc::Search',
        admin_partners_search: 'CorevistAPI::Services::Admin::Partners::SearchService'
      }
    end
  end
end
