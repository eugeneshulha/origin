module CorevistAPI
  class Services::User::RegistrationService < CorevistAPI::Services::BaseServiceWithForm
    def perform
      CorevistAPI::Mailer.user_registration(@form.to_json).deliver_later
      CorevistAPI::Admin::Mailer.user_registration(@form.to_json).deliver_later

      result
    end
  end
end
