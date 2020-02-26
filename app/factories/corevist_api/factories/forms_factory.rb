module CorevistAPI
  class Factories::FormsFactory < CorevistAPI::Factories::BaseFactory
    def initialize
      @storage = {
        admin_users_step_1: 'CorevistAPI::Forms::Admin::Users::Step1',
        admin_users_step_2: 'CorevistAPI::Forms::Admin::Users::Step2',
        admin_users_step_3: 'CorevistAPI::Forms::Admin::Users::Step3',
        admin_users_step_4: 'CorevistAPI::Forms::Admin::Users::Step4',
        admin_users_step_5: 'CorevistAPI::Forms::Admin::Users::Step5',
        admin_users_step_6: 'CorevistAPI::Forms::Admin::Users::Step6',
        admin_users_index: 'CorevistAPI::Forms::Admin::Users::IndexForm',
        user_registration: 'CorevistAPI::Forms::User::Registration',
        set_new_password: 'CorevistAPI::Forms::User::SetNewPassword',
        search_invoices: 'CorevistAPI::Forms::Invoice::Search',
        search_salesdoc: 'CorevistAPI::Forms::Salesdoc::Search',
        partners_search: 'CorevistAPI::Forms::Admin::Partners::SearchForm',
        login: 'CorevistAPI::Forms::User::Login',
        openitems_index: 'CorevistAPI::Forms::OpenItems::IndexForm',
        summaries_salesdocs_index: 'CorevistAPI::Forms::Summaries::SalesdocIndexForm',
        admin_roles_index: 'CorevistAPI::Forms::Admin::Roles::IndexForm',
        admin_roles_create: 'CorevistAPI::Forms::Admin::Roles::CreateForm',
        admin_roles_update: 'CorevistAPI::Forms::Admin::Roles::UpdateForm',
        admin_roles_show: 'CorevistAPI::Forms::Admin::Roles::ShowForm',
        admin_roles_destroy: 'CorevistAPI::Forms::Admin::Roles::DestroyForm'
      }
    end
  end
end
