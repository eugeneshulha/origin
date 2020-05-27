module CorevistAPI
  class Factories::FormsFactory < CorevistAPI::Factories::BaseFactory
    def initialize
      @storage = {
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

        admin_roles_index: 'CorevistAPI::Forms::Admin::Roles::IndexForm',
        admin_roles_create: 'CorevistAPI::Forms::Admin::Roles::CreateForm',
        admin_roles_update: 'CorevistAPI::Forms::Admin::Roles::UpdateForm',
        admin_roles_edit: 'CorevistAPI::Forms::Admin::Roles::EditForm',
        admin_roles_destroy: 'CorevistAPI::Forms::Admin::Roles::DestroyForm',

        admin_permissions_index: 'CorevistAPI::Forms::Admin::Permissions::IndexForm',

        # SystemSettings > Microsites
        admin_system_settings_microsites_index: 'CorevistAPI::Forms::Admin::SystemSettings::Microsites::IndexForm',
        admin_system_settings_microsites_create: 'CorevistAPI::Forms::Admin::SystemSettings::Microsites::CreateForm',
        admin_system_settings_microsites_update: 'CorevistAPI::Forms::Admin::SystemSettings::Microsites::UpdateForm',
        admin_system_settings_microsites_destroy: 'CorevistAPI::Forms::Admin::SystemSettings::Microsites::DestroyForm',

        admin_translations_index: 'CorevistAPI::Forms::Admin::Translations::IndexForm',
        admin_translations_create: 'CorevistAPI::Forms::Admin::Translations::CreateForm',
        admin_translations_update: 'CorevistAPI::Forms::Admin::Translations::UpdateForm',
        admin_translations_destroy: 'CorevistAPI::Forms::Admin::Translations::DestroyForm',

        user_registration: 'CorevistAPI::Forms::User::Registration',
        set_new_password: 'CorevistAPI::Forms::User::SetNewPassword',
        invoices_index: 'CorevistAPI::Forms::Invoice::ListForm',
        salesdocs_index: 'CorevistAPI::Forms::Salesdoc::ListForm',
        partners_index: 'CorevistAPI::Forms::Admin::Partners::IndexForm',
        sessions_create: 'CorevistAPI::Forms::User::Login',
        open_items_index: 'CorevistAPI::Forms::OpenItems::IndexForm',

        sort_salesdoc_items: 'CorevistAPI::Forms::Document::SortItemsForm',
        sort_invoice_items: 'CorevistAPI::Forms::Document::SortItemsForm',
        output_types_index: 'CorevistAPI::Forms::Document::OutputTypesList',
        show_output_type: 'CorevistAPI::Forms::Document::ShowOutputType',
        account_details_show: 'CorevistAPI::Forms::AccountDetails::Show',
        payments_create: 'CorevistAPI::Forms::Invoice::Pay',
        salesdocs_questions_create: 'CorevistAPI::Forms::Salesdoc::Question::Create',
        invoices_questions_create: 'CorevistAPI::Forms::Invoice::Question::Create'
      }
    end
  end
end
