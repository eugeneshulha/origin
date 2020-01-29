module CorevistAPI
  class Services::User::RegistrationService < CorevistAPI::Services::BaseServiceWithForm
    def perform
      CorevistAPI::Mailer.user_registration(@form).deliver_now
      CorevistAPI::Admin::Mailer.user_registration(@form).deliver_now
    end
  end
end
