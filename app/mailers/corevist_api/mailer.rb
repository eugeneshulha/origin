module CorevistAPI
  class Mailer < BaseMailer
    def user_registration(form)
      @form = form
      mail to: form.email
    end
  end
end
