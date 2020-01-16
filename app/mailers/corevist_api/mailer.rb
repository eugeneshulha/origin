module CorevistAPI
  class Mailer < ApplicationMailer
    def user_registration(form)
      @form = form
      mail to: form.email
    end
  end
end
