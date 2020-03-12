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
        admin_users_index: 'CorevistAPI::Services::Admin::Users::IndexService',
        admin_users_show: 'CorevistAPI::Services::Admin::Users::ShowService',
        admin_users_update: 'CorevistAPI::Services::Admin::Users::UpdateService',
        admin_users_destroy: 'CorevistAPI::Services::Admin::Users::DestroyService',
        admin_users_index_filter: 'CorevistAPI::Services::Admin::Users::FilterService',
        user_registration: 'CorevistAPI::Services::User::RegistrationService',
        invoice_display: 'CorevistAPI::Services::Invoice::DisplayService',
        salesdoc_display: 'CorevistAPI::Services::Salesdoc::DisplayService',
        invoice_list: 'CorevistAPI::Services::Invoice::ListService',
        salesdoc_list: 'CorevistAPI::Services::Salesdoc::ListService',
        partners_search: 'CorevistAPI::Services::Admin::Partners::SearchService',
        page_configs_read: 'CorevistAPI::Services::PageConfigs::Read',
        openitems_index: 'CorevistAPI::Services::OpenItems::SearchService',
        summaries_salesdocs_index: 'CorevistAPI::Services::Summaries::Salesdocs::SearchService',
        admin_roles_index: 'CorevistAPI::Services::Admin::Roles::IndexService',
        admin_roles_create: 'CorevistAPI::Services::Admin::Roles::CreateService',
        admin_roles_update: 'CorevistAPI::Services::Admin::Roles::UpdateService',
        admin_roles_show: 'CorevistAPI::Services::Admin::Roles::ShowService',
        admin_roles_index_filter: 'CorevistAPI::Services::Admin::Roles::FilterService',
        admin_roles_destroy: 'CorevistAPI::Services::Admin::Roles::DestroyService',
        admin_users_steps: 'CorevistAPI::Services::Admin::Users::StepsService'
      }
    end
  end
end
