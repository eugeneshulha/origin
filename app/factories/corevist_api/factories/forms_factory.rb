module CorevistAPI
  class Factories::FormsFactory < CorevistAPI::Factories::BaseFactory
    def initialize
      @storage = {
          admin_user_step_1: 'CorevistAPI::Admin::User::Step1',
          admin_user_step_2: 'CorevistAPI::Admin::User::Step2',
          admin_user_step_3: 'CorevistAPI::Admin::User::Step3',
          admin_user_step_4: 'CorevistAPI::Admin::User::Step4',
          admin_user_step_5: 'CorevistAPI::Admin::User::Step5',
          admin_user_step_6: 'CorevistAPI::Admin::User::Step6',
          user_registration: 'CorevistAPI::Forms::User::Registration',
          search_invoices:'CorevistAPI::Forms::Invoice::Search',
          search_salesdoc: 'CorevistAPI::Forms::Salesdoc::Search'
      }
    end
  end
end
