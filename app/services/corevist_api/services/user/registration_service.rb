module CorevistAPI
  class User::RegistrationService < CorevistAPI::BaseServiceWithForm
    def perform
      CorevistAPI::Mailer.user_registration(@form).deliver_now
      CorevistAPI::Admin::Mailer.user_registration(@form).deliver_now
    end
  end
end
