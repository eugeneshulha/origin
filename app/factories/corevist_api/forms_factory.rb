module CorevistAPI
  class FormsFactory < CorevistAPI::BaseFactory
    def initialize
      @storage = {
          admin_user_step_1: 'CorevistAPI::Admin::User::Step1',
          admin_user_step_2: 'CorevistAPI::Admin::User::Step2',
          admin_user_step_3: 'CorevistAPI::Admin::User::Step3',
          admin_user_step_4: 'CorevistAPI::Admin::User::Step4',
          admin_user_step_5: 'CorevistAPI::Admin::User::Step5',
          admin_user_step_6: 'CorevistAPI::Admin::User::Step6',
          user_registration: 'CorevistAPI::User::RegistrationForm',
          search_invoices: 'CorevistAPI::Invoice::SearchForm'
      }
    end
  end
end
