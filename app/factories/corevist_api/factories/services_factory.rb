module CorevistAPI
  class Factories::ServicesFactory < CorevistAPI::Factories::BaseFactory
    def initialize
      @storage = {
        admin_users_create_step_1: 'CorevistAPI::Services::Admin::Users::Step1CreationService',
        admin_users_create_step_2: 'CorevistAPI::Services::Admin::Users::Step2CreationService',
        admin_users_create_step_3: 'CorevistAPI::Services::Admin::Users::Step3CreationService',
        admin_users_create_step_4: 'CorevistAPI::Services::Admin::Users::Step4CreationService',
        admin_users_create_step_5: 'CorevistAPI::Services::Admin::Users::Step5CreationService',
        admin_users_create_step_6: 'CorevistAPI::Services::Admin::Users::Step6CreationService',
        admin_users_index: 'CorevistAPI::Services::Admin::Users::IndexService',
        admin_users_show: 'CorevistAPI::Services::Admin::Users::ShowService',
        admin_users_update: 'CorevistAPI::Services::Admin::Users::UpdateService',
        admin_users_destroy: 'CorevistAPI::Services::Admin::Users::DestroyService',
        admin_users_partners_index: 'CorevistAPI::Services::Admin::Users::Partners::IndexService',
        admin_users_partners_destroy: 'CorevistAPI::Services::Admin::Users::Partners::DestroyService',
        admin_users_index_filter: 'CorevistAPI::Services::Admin::Users::FilterService',
        user_registration: 'CorevistAPI::Services::User::RegistrationService',
        invoices_show: 'CorevistAPI::Services::Invoice::DisplayService',
        salesdocs_show: 'CorevistAPI::Services::Salesdoc::DisplayService',
        invoices_index: 'CorevistAPI::Services::Invoice::ListService',
        salesdocs_index: 'CorevistAPI::Services::Salesdoc::ListService',
        partners_index: 'CorevistAPI::Services::Admin::Partners::IndexService',
        page_configs_read: 'CorevistAPI::Services::PageConfigs::Read',
        open_items_index: 'CorevistAPI::Services::OpenItems::SearchService',
        admin_roles_index: 'CorevistAPI::Services::Admin::Roles::IndexService',
        admin_roles_create: 'CorevistAPI::Services::Admin::Roles::CreateService',
        admin_roles_update: 'CorevistAPI::Services::Admin::Roles::UpdateService',
        admin_roles_show: 'CorevistAPI::Services::Admin::Roles::ShowService',
        admin_roles_index_filter: 'CorevistAPI::Services::Admin::Roles::FilterService',
        admin_roles_destroy: 'CorevistAPI::Services::Admin::Roles::DestroyService',
        admin_users_steps: 'CorevistAPI::Services::Admin::Users::StepsService',
        sort_document_items: 'CorevistAPI::Services::Document::SortItemsService',
        output_types_index: 'CorevistAPI::Services::Document::OutputTypesList',
        show_output_type: 'CorevistAPI::Services::Document::ShowOutputType',
        account_details_show: 'CorevistAPI::Services::AccountDetails::Show',
        payments_create: 'CorevistAPI::Services::Invoice::Pay',
        invoices_questions_create: 'CorevistAPI::Services::Invoice::Question::Create',
        salesdocs_questions_create: 'CorevistAPI::Services::Salesdoc::Question::Create',
        site_configs_index: 'CorevistAPI::Services::SiteConfigs::Index'
      }
    end
  end
end
