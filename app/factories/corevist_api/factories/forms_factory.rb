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
        user_registration: 'CorevistAPI::Forms::User::Registration',
        set_new_password: 'CorevistAPI::Forms::User::SetNewPassword',
        search_invoices: 'CorevistAPI::Forms::Invoice::Search',
        search_salesdoc: 'CorevistAPI::Forms::Salesdoc::Search',
        partners_search: 'CorevistAPI::Forms::Admin::Partners::SearchForm',
        login: 'CorevistAPI::Forms::User::Login'
      }
    end
  end
end
