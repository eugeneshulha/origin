module CorevistAPI
  class Factories::FormsFactory < CorevistAPI::Factories::BaseFactory
    def initialize
      @storage = {
        # Admin > Users
        admin_users_create_step_1: 'CorevistAPI::Forms::Admin::Users::Step1',
        admin_users_create_step_2: 'CorevistAPI::Forms::Admin::Users::Step2',
        admin_users_create_step_3: 'CorevistAPI::Forms::Admin::Users::Step3',
        admin_users_create_step_4: 'CorevistAPI::Forms::Admin::Users::Step4',
        admin_users_create_step_5: 'CorevistAPI::Forms::Admin::Users::Step5',
        admin_users_create_step_6: 'CorevistAPI::Forms::Admin::Users::Step6',
        admin_users_index: 'CorevistAPI::Forms::Admin::Users::IndexForm',
        admin_users_show: 'CorevistAPI::Forms::Admin::Users::ShowForm',
        admin_users_update: 'CorevistAPI::Forms::Admin::Users::UpdateForm',
        admin_users_destroy: 'CorevistAPI::Forms::Admin::Users::DestroyForm',
        admin_users_partners_index: 'CorevistAPI::Forms::Admin::Users::Partners::IndexForm',
        admin_users_partners_destroy: 'CorevistAPI::Forms::Admin::Users::Partners::DestroyForm',

        # Admin > Roles
        admin_roles_index: 'CorevistAPI::Forms::Admin::Roles::IndexForm',
        admin_roles_create: 'CorevistAPI::Forms::Admin::Roles::CreateForm',
        admin_roles_update: 'CorevistAPI::Forms::Admin::Roles::UpdateForm',
        admin_roles_edit: 'CorevistAPI::Forms::Admin::Roles::EditForm',
        admin_roles_destroy: 'CorevistAPI::Forms::Admin::Roles::DestroyForm',

        # Admin > Permissions
        admin_permissions_index: 'CorevistAPI::Forms::Admin::Permissions::IndexForm',

        # Admin > SystemSettings > Microsites
        admin_system_settings_microsites_index: 'CorevistAPI::Forms::Admin::SystemSettings::Microsites::IndexForm',
        admin_system_settings_microsites_create: 'CorevistAPI::Forms::Admin::SystemSettings::Microsites::CreateForm',
        admin_system_settings_microsites_update: 'CorevistAPI::Forms::Admin::SystemSettings::Microsites::UpdateForm',
        admin_system_settings_microsites_destroy: 'CorevistAPI::Forms::Admin::SystemSettings::Microsites::DestroyForm',

        # Admin > SystemSettings > SalesAreas
        admin_system_settings_sales_areas_index: 'CorevistAPI::Forms::Admin::SystemSettings::SalesAreas::IndexForm',
        admin_system_settings_sales_areas_create_step_1: 'CorevistAPI::Forms::Admin::SystemSettings::SalesAreas::Step1',
        admin_system_settings_sales_areas_create_step_2: 'CorevistAPI::Forms::Admin::SystemSettings::SalesAreas::Step2',
        admin_system_settings_sales_areas_create_step_3: 'CorevistAPI::Forms::Admin::SystemSettings::SalesAreas::Step3',
        admin_system_settings_sales_areas_update: 'CorevistAPI::Forms::Admin::SystemSettings::SalesAreas::UpdateForm',
        admin_system_settings_sales_areas_destroy: 'CorevistAPI::Forms::Admin::SystemSettings::SalesAreas::DestroyForm',

        # Admin > SystemSettings > DocTypes
        admin_system_settings_doc_types_index: 'CorevistAPI::Forms::Admin::SystemSettings::DocTypes::IndexForm',
        admin_system_settings_doc_types_create: 'CorevistAPI::Forms::Admin::SystemSettings::DocTypes::CreateForm',
        admin_system_settings_doc_types_update: 'CorevistAPI::Forms::Admin::SystemSettings::DocTypes::UpdateForm',
        admin_system_settings_doc_types_destroy: 'CorevistAPI::Forms::Admin::SystemSettings::DocTypes::DestroyForm',

        # Admin > SystemSettings > DocCategories
        admin_system_settings_doc_categories_index: 'CorevistAPI::Forms::Admin::SystemSettings::DocCategories::IndexForm',

        # Admin > SystemSettings > SAPMaintenance > SAPDowntimes
        admin_system_settings_sap_maintenance_sap_downtimes_index: 'CorevistAPI::Forms::Admin::SystemSettings::SAPMaintenance::SAPDowntimes::IndexForm',
        admin_system_settings_sap_maintenance_sap_downtimes_create: 'CorevistAPI::Forms::Admin::SystemSettings::SAPMaintenance::SAPDowntimes::CreateForm',
        admin_system_settings_sap_maintenance_sap_downtimes_update: 'CorevistAPI::Forms::Admin::SystemSettings::SAPMaintenance::SAPDowntimes::UpdateForm',
        # admin_system_settings_sap_maintenance_sap_downtimes_destroy: 'CorevistAPI::Forms::Admin::SystemSettings::SAPMaintenance::SAPDowntimes::DestroyForm',

        # Admin > SystemSettings > SAPMaintenance > SAPConnections
        admin_system_settings_sap_maintenance_sap_connections_index: 'CorevistAPI::Forms::Admin::SystemSettings::SAPMaintenance::SAPConnections::IndexForm',
        admin_system_settings_sap_maintenance_sap_connections_create: 'CorevistAPI::Forms::Admin::SystemSettings::SAPMaintenance::SAPConnections::CreateForm',
        admin_system_settings_sap_maintenance_sap_connections_update: 'CorevistAPI::Forms::Admin::SystemSettings::SAPMaintenance::SAPConnections::UpdateForm',
        # admin_system_settings_sap_maintenance_sap_connections_destroy: 'CorevistAPI::Forms::Admin::SystemSettings::SAPMaintenance::SAPConnections::DestroyForm',

        # Admin > Translations
        admin_translations_index: 'CorevistAPI::Forms::Admin::Translations::IndexForm',
        admin_translations_create: 'CorevistAPI::Forms::Admin::Translations::CreateForm',
        admin_translations_update: 'CorevistAPI::Forms::Admin::Translations::UpdateForm',
        admin_translations_destroy: 'CorevistAPI::Forms::Admin::Translations::DestroyForm',

        # Open Items
        open_items_index: 'CorevistAPI::Forms::OpenItems::IndexForm',
        open_items_create: 'CorevistAPI::Forms::OpenItems::CreateForm',

        # Invoices
        invoices_index: 'CorevistAPI::Forms::Invoices::IndexForm',
        invoices_items_index: 'CorevistAPI::Forms::Invoices::Items::IndexForm',
        invoices_questions_create: 'CorevistAPI::Forms::Invoices::Questions::CreateForm',

        # Salesdocs
        salesdocs_index: 'CorevistAPI::Forms::Salesdocs::IndexForm',
        salesdocs_items_index: 'CorevistAPI::Forms::Salesdocs::Items::IndexForm',
        salesdocs_questions_create: 'CorevistAPI::Forms::Salesdocs::Questions::CreateForm',

        # Payments
        payments_index: 'CorevistAPI::Forms::Payments::IndexForm',
        payments_items_index: 'CorevistAPI::Forms::Payments::Items::IndexForm',
        payments_questions_create: 'CorevistAPI::Forms::Payments::Question::CreateForm',

        # Carts
        carts_items_create: 'CorevistAPI::Forms::Carts::Items::CreateForm',
        carts_items_update: 'CorevistAPI::Forms::Carts::Items::UpdateForm',


        # Accounts
        accounts_update: 'CorevistAPI::Forms::Accounts::UpdateForm',


        user_registration: 'CorevistAPI::Forms::User::Registration',
        set_new_password: 'CorevistAPI::Forms::User::SetNewPassword',
        partners_index: 'CorevistAPI::Forms::Admin::Partners::IndexForm',
        sessions_create: 'CorevistAPI::Forms::User::Login',
        output_types_index: 'CorevistAPI::Forms::Document::OutputTypesList',
        output_types_show: 'CorevistAPI::Forms::Document::ShowOutputType',
        account_details_show: 'CorevistAPI::Forms::AccountDetails::Show',
      }
    end
  end
end
