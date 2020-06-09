module CorevistAPI::Services::User
  class RegistrationService < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      CorevistAPI::Mailer.user_registration(@form.as_json).deliver_later
      CorevistAPI::Admin::Mailer.user_registration(@form.as_json).deliver_later

      result
    end
  end
end
