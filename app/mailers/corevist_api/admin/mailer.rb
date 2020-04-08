module CorevistAPI
  class Admin::Mailer < ApplicationMailer
    default template_path: 'corevist_api/mailer/admin'

    def user_registration(form)
      @form = form
      mail to: form.email
    end

    def submit_invoice_question(form, user)
      @form = form
      mail to: user.email
    end

    def submit_salesdoc_question(form, user)
      @form = form
      mail to: user.email
    end
  end
end
