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
        admin_users_steps: 'CorevistAPI::Services::Admin::Users::StepsService',

        # Admin > Roles
        admin_roles_index: 'CorevistAPI::Services::Admin::Roles::IndexService',
        admin_roles_create: 'CorevistAPI::Services::Admin::Roles::CreateService',
        admin_roles_show: 'CorevistAPI::Services::Admin::Roles::ShowService',
        admin_roles_update: 'CorevistAPI::Services::Admin::Roles::UpdateService',
        admin_roles_edit: 'CorevistAPI::Services::Admin::Roles::EditService',
        admin_roles_index_filter: 'CorevistAPI::Services::Admin::Roles::FilterService',
        admin_roles_destroy: 'CorevistAPI::Services::Admin::Roles::DestroyService',

        # Admin > Permissions
        admin_permissions_index: 'CorevistAPI::Services::Admin::Permissions::IndexService',

        # Admin > SystemSettings > Microsites
        admin_system_settings_microsites_index: 'CorevistAPI::Services::Admin::SystemSettings::Microsites::IndexService',
        admin_system_settings_microsites_create: 'CorevistAPI::Services::Admin::SystemSettings::Microsites::CreateService',
        admin_system_settings_microsites_show: 'CorevistAPI::Services::Admin::SystemSettings::Microsites::ShowService',
        admin_system_settings_microsites_update: 'CorevistAPI::Services::Admin::SystemSettings::Microsites::UpdateService',
        admin_system_settings_microsites_destroy: 'CorevistAPI::Services::Admin::SystemSettings::Microsites::DestroyService',

        # Admin > SystemSettings > SalesAreas
        admin_system_settings_sales_areas_index: 'CorevistAPI::Services::Admin::SystemSettings::SalesAreas::IndexService',
        admin_system_settings_sales_areas_create_step_1: 'CorevistAPI::Services::Admin::SystemSettings::SalesAreas::Step1Service',
        admin_system_settings_sales_areas_create_step_2: 'CorevistAPI::Services::Admin::SystemSettings::SalesAreas::Step2Service',
        admin_system_settings_sales_areas_create_step_3: 'CorevistAPI::Services::Admin::SystemSettings::SalesAreas::Step3Service',
        admin_system_settings_sales_areas_show: 'CorevistAPI::Services::Admin::SystemSettings::SalesAreas::ShowService',
        admin_system_settings_sales_areas_update: 'CorevistAPI::Services::Admin::SystemSettings::SalesAreas::UpdateService',
        admin_system_settings_sales_areas_destroy: 'CorevistAPI::Services::Admin::SystemSettings::SalesAreas::DestroyService',

        # Admin > SystemSettings > DocTypes
        admin_system_settings_doc_types_index: 'CorevistAPI::Services::Admin::SystemSettings::DocTypes::IndexService',
        admin_system_settings_doc_types_create: 'CorevistAPI::Services::Admin::SystemSettings::DocTypes::CreateService',
        admin_system_settings_doc_types_show: 'CorevistAPI::Services::Admin::SystemSettings::DocTypes::ShowService',
        admin_system_settings_doc_types_update: 'CorevistAPI::Services::Admin::SystemSettings::DocTypes::UpdateService',
        admin_system_settings_doc_types_destroy: 'CorevistAPI::Services::Admin::SystemSettings::DocTypes::DestroyService',

        # Admin > SystemSettings > DocCategories
        admin_system_settings_doc_categories_index: 'CorevistAPI::Services::Admin::SystemSettings::DocCategories::IndexService',

        # Admin > SystemSettings > SAPMaintenance > SAPDowntimes
        admin_system_settings_sap_maintenance_sap_downtimes_index: 'CorevistAPI::Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes::IndexService',
        admin_system_settings_sap_maintenance_sap_downtimes_create: 'CorevistAPI::Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes::CreateService',
        admin_system_settings_sap_maintenance_sap_downtimes_show: 'CorevistAPI::Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes::ShowService',
        admin_system_settings_sap_maintenance_sap_downtimes_update: 'CorevistAPI::Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes::UpdateService',
        admin_system_settings_sap_maintenance_sap_downtimes_destroy: 'CorevistAPI::Services::Admin::SystemSettings::SAPMaintenance::SAPDowntimes::DestroyService',

        # Admin > SystemSettings > SAPMaintenance > SAPConnections
        admin_system_settings_sap_maintenance_sap_connections_index: 'CorevistAPI::Services::Admin::SystemSettings::SAPMaintenance::SAPConnections::IndexService',
        admin_system_settings_sap_maintenance_sap_connections_create: 'CorevistAPI::Services::Admin::SystemSettings::SAPMaintenance::SAPConnections::CreateService',
        admin_system_settings_sap_maintenance_sap_connections_show: 'CorevistAPI::Services::Admin::SystemSettings::SAPMaintenance::SAPConnections::ShowService',
        admin_system_settings_sap_maintenance_sap_connections_update: 'CorevistAPI::Services::Admin::SystemSettings::SAPMaintenance::SAPConnections::UpdateService',
        admin_system_settings_sap_maintenance_sap_connections_destroy: 'CorevistAPI::Services::Admin::SystemSettings::SAPMaintenance::SAPConnections::DestroyService',
        admin_system_settings_sap_maintenance_sap_connections_ping: 'CorevistAPI::Services::Admin::SystemSettings::SAPMaintenance::SAPConnections::PingService',

        # Admin > Translations
        admin_translations_index_filter: 'CorevistAPI::Services::Admin::Translations::FilterService',
        admin_translations_index: 'CorevistAPI::Services::Admin::Translations::IndexService',
        admin_translations_create: 'CorevistAPI::Services::Admin::Translations::CreateService',
        admin_translations_update: 'CorevistAPI::Services::Admin::Translations::UpdateService',
        admin_translations_destroy: 'CorevistAPI::Services::Admin::Translations::DestroyService',

        # Open Items
        open_items_index: 'CorevistAPI::Services::OpenItems::IndexService',
        open_items_create: 'CorevistAPI::Services::OpenItems::CreateService',

        # Invoices
        invoices_index: 'CorevistAPI::Services::Invoices::IndexService',
        invoices_items_index: 'CorevistAPI::Services::Invoices::Items::IndexService',
        invoices_show: 'CorevistAPI::Services::Invoices::ShowService',
        invoices_questions_create: 'CorevistAPI::Services::Invoices::Questions::CreateService',

        # Salesdocs
        salesdocs_index: 'CorevistAPI::Services::Salesdocs::IndexService',
        salesdocs_items_index: 'CorevistAPI::Services::Salesdocs::Items::IndexService',
        salesdocs_show: 'CorevistAPI::Services::Salesdocs::ShowService',
        salesdocs_questions_create: 'CorevistAPI::Services::Salesdocs::Question::CreateService',

        # Payments
        payments_index: 'CorevistAPI::Services::Payments::IndexService',
        payments_items_index: 'CorevistAPI::Services::Payments::Items::IndexService',
        payments_show: 'CorevistAPI::Services::Payments::ShowService',
        payments_questions_create: 'CorevistAPI::Services::Payments::Questions::CreateService',

        # Accounts/Profiles
        accounts_show: 'CorevistAPI::Services::Accounts::ShowService',
        accounts_update: 'CorevistAPI::Services::Accounts::UpdateService',

        output_types_index: 'CorevistAPI::Services::Document::OutputTypesList',
        output_types_show: 'CorevistAPI::Services::Document::ShowOutputType',
        account_details_show: 'CorevistAPI::Services::AccountDetails::Show',
        site_configs_index: 'CorevistAPI::Services::SiteConfigs::Index',

        partners_index: 'CorevistAPI::Services::Admin::Partners::IndexService',
        page_configs_read: 'CorevistAPI::Services::PageConfigs::Read',
        page_configs_navigation: 'CorevistAPI::Services::PageConfigs::Navigation',

        login: 'CorevistAPI::Services::User::LoginService',
        refresh_token: 'CorevistAPI::Services::Token::RefreshService',
        user_registration: 'CorevistAPI::Services::User::RegistrationService',

        # Cart
        carts_get_last_active: 'CorevistAPI::Services::Carts::GetLastActiveService',

        # SAP
        connect_to_sap: 'CorevistAPI::Services::ConnectToSAPService'
      }
    end
  end
end
