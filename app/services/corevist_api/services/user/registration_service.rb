module CorevistAPI
  class Services::User::RegistrationService < CorevistAPI::Services::BaseServiceWithForm
    def perform
      CorevistAPI::Mailer.user_registration(@form).deliver_later
      CorevistAPI::Admin::Mailer.user_registration(@form).deliver_later
    end
  end
end
