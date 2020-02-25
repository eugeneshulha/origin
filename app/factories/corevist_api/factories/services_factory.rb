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
        invoice_display: 'CorevistAPI::Services::Invoice::DisplayService',
        salesdoc_display: 'CorevistAPI::Services::Salesdoc::DisplayService',
        invoice_list: 'CorevistAPI::Services::Invoice::ListService',
        salesdoc_list: 'CorevistAPI::Services::Salesdoc::ListService',
        partners_search: 'CorevistAPI::Services::Admin::Partners::SearchService',
        page_configs_read: 'CorevistAPI::Services::PageConfigs::Read'
      }
    end
  end
end
